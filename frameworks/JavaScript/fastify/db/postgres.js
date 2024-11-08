const knex = require("knex")({
  client: "pg",
  connection: {
    host: "bw-database",
    user: "benchmarkdbuser",
    password: "benchmarkdbpass",
    database: "hello_world"
  }
});

async function allFortunes() {
  return knex("Fortune").select("*");
}

async function getWorld(id) {
  return knex("World")
    .first()
    .where({ id });
}

async function saveWorlds(worlds) {
  const updates = [];

  worlds.forEach(world => {
    const { id, randomNumber } = world;

    updates.push(
      knex("World")
        .update({ randomnumber: randomNumber })
        .where({ id })
    );
  });

  return Promise.all(updates);
}

module.exports = {
  getWorld,
  saveWorlds,
  allFortunes
};
