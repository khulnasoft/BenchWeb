package com.khulnasoft.ee7.tests;

import java.util.ArrayList;
import java.util.List;

import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.QueryParam;
import jakarta.ws.rs.core.MediaType;

import com.khulnasoft.ee7.model.World;
import com.khulnasoft.ee7.util.Helpers;

@Path("/updates")
public class Updates {

    private static final int MIN_QUERIES = 1;
    private static final int MAX_QUERIES = 500;

    @Inject
    private TestActions actions;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<World> update(@QueryParam("queries") final String queries) {
        final int iterations = Helpers.boundedIntegerFromNullableString(queries, MIN_QUERIES, MAX_QUERIES);

        final List<World> worlds = new ArrayList<>(iterations);
        for (int i = 0; i < iterations; i++) {
            worlds.add(actions.updateWorld(Helpers.randomWorldId()));
        }
        return worlds;
    }
}
