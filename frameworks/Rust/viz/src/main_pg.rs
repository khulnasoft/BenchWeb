use std::{
    sync::Arc,
    thread::{available_parallelism, spawn},
};

use viz::{
    header::{HeaderValue, SERVER},
    types::State,
    Request, RequestExt, Response, ResponseExt, Result, Router,
};
use yarte::Template;

mod db_pg;
mod models;
mod server;
mod utils;

use db_pg::{get_conn, PgConnection};

#[derive(Template)]
#[template(path = "fortune.hbs")]
pub struct FortunesTemplate {
    pub fortunes: Vec<models::Fortune>,
}

const DB_URL: &str =
    "postgres://benchmarkdbuser:benchmarkdbpass@bw-database/hello_world";

async fn db(req: Request) -> Result<Response> {
    let conn = get_conn(req.state::<Arc<PgConnection>>())?;

    let world = conn.get_world().await?;

    let mut res = Response::json(world)?;
    res.headers_mut()
        .insert(SERVER, HeaderValue::from_static("Viz"));
    Ok(res)
}

async fn fortunes(req: Request) -> Result<Response> {
    let conn = get_conn(req.state::<Arc<PgConnection>>())?;

    let fortunes = conn.tell_fortune().await?;

    let buf = FortunesTemplate { fortunes }
        .call()
        .expect("error rendering template");

    let mut res = Response::html(buf);
    res.headers_mut()
        .insert(SERVER, HeaderValue::from_static("Viz"));
    Ok(res)
}

async fn queries(req: Request) -> Result<Response> {
    let conn = get_conn(req.state::<Arc<PgConnection>>())?;
    let count = utils::get_query_param(req.query_string());

    let worlds = conn.get_worlds(count).await?;

    let mut res = Response::json(worlds)?;
    res.headers_mut()
        .insert(SERVER, HeaderValue::from_static("Viz"));
    Ok(res)
}

async fn updates(req: Request) -> Result<Response> {
    let conn = get_conn(req.state::<Arc<PgConnection>>())?;
    let count = utils::get_query_param(req.query_string());

    let worlds = conn.update(count).await?;

    let mut res = Response::json(worlds)?;
    res.headers_mut()
        .insert(SERVER, HeaderValue::from_static("Viz"));
    Ok(res)
}

fn main() {
    let rt = tokio::runtime::Builder::new_current_thread()
        .enable_all()
        .build()
        .unwrap();

    for _ in 1..available_parallelism().map(|n| n.get()).unwrap_or(16) {
        spawn(move || {
            let rt = tokio::runtime::Builder::new_current_thread()
                .enable_all()
                .build()
                .unwrap();
            rt.block_on(serve());
        });
    }

    rt.block_on(serve());
}

async fn serve() {
    let conn = PgConnection::connect(DB_URL).await;

    let app = Router::new()
        .get("/db", db)
        .get("/fortunes", fortunes)
        .get("/queries", queries)
        .get("/updates", updates)
        .with(State::new(conn));

    server::serve(app).await.unwrap()
}
