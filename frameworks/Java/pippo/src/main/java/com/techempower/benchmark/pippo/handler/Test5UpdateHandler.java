package com.khulnasoft.benchmark.pippo.handler;

import com.dslplatform.json.DslJson;
import com.khulnasoft.benchmark.pippo.BenchmarkUtils;
import com.khulnasoft.benchmark.pippo.dao.Dao;
import com.khulnasoft.benchmark.pippo.model.World;
import ro.pippo.core.HttpConstants;
import ro.pippo.core.route.RouteContext;
import ro.pippo.core.route.RouteHandler;

import java.io.IOException;
import java.util.List;

/**
 * <p>Test type 5: Database updates</p>
 *
 * <p>Example request:</p>
 *
 * <pre>
 * GET /updates?queries=10 HTTP/1.1
 * Host: server
 * User-Agent: Mozilla/5.0 (X11; Linux x86_64) Gecko/20130501 Firefox/30.0 AppleWebKit/600.00 Chrome/30.0.0000.0 Trident/10.0 Safari/600.00
 * Cookie: uid=12345678901234567890; __utma=1.1234567890.1234567890.1234567890.1234567890.12; wd=2560x1600
 * Accept: text/html,application/xhtml+xml,application/xml;q=0.9,"*&#47;"/"*&#47;";q=0.8
 * Accept-Language: en-US,en;q=0.5
 * Connection: keep-alive
 * </pre>
 *
 * <p>Example response:</p>
 *
 * <pre>
 * HTTP/1.1 200 OK
 * Content-Length: 315
 * Content-Type: application/json
 * Server: Example
 * Date: Wed, 17 Apr 2013 12:00:00 GMT
 *
 * [{"id":4174,"randomNumber":331},{"id":51,"randomNumber":6544},
 * {"id":4462,"randomNumber":952},{"id":2221,"randomNumber":532},
 * {"id":9276,"randomNumber":3097},{"id":3056,"randomNumber":7293},
 * {"id":6964,"randomNumber":620},{"id":675,"randomNumber":6601},
 * {"id":8414,"randomNumber":6569},{"id":2753,"randomNumber":4065}]
 * </pre>
 */
public class Test5UpdateHandler implements RouteHandler<RouteContext> {

	public Test5UpdateHandler(Dao dao) {
		this.dao = dao;
	}

	@Override
	public void handle(RouteContext routeContext) {

		int queries = BenchmarkUtils.getQueriesParam(routeContext);

		List<World> worlds = dao.getRandomWorlds(queries);

		for (World world : worlds) {
			int newRandomNumber;
			do {
				newRandomNumber = BenchmarkUtils.random();
			} while (newRandomNumber == world.randomNumber);
			world.randomNumber = newRandomNumber;
		}

		dao.updateRandomWorlds(worlds);

		try {
			WorldJsonMapper.serialize(
				worlds,
				routeContext
					.getResponse()
					.contentType(HttpConstants.ContentType.APPLICATION_JSON)
					.header(BenchmarkUtils.Header.SERVER, "Pippo")
					.getOutputStream()
			);
		} catch (IOException e) {
			throw new RuntimeException(e);
		}

	}

	private static final DslJson<World> WorldJsonMapper = new DslJson<>();

	private final Dao dao;

}