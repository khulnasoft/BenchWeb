package com.networknt.khulnasoft;

import io.undertow.server.HttpServerExchange;

import java.util.Deque;
import java.util.concurrent.ThreadLocalRandom;

/**
 * Provides utility methods for the benchmark tests.
 */
public final class Helper {

    private Helper() {
        throw new AssertionError();
    }

    /**
     * Returns the value of the "queries" request parameter, which is an integer
     * bound between 1 and 500 with a default value of 1.
     *
     * @param exchange the current HTTP exchange
     * @return the value of the "queries" request parameter
     */
    public static int getQueries(HttpServerExchange exchange) {
        Deque<String> values = exchange.getQueryParameters().get("queries");
        if (values == null) {
            return 1;
        }
        String textValue = values.peekFirst();
        if (textValue == null) {
            return 1;
        }
        try {
            int parsedValue = Integer.parseInt(textValue);
            return Math.min(500, Math.max(1, parsedValue));
        } catch (NumberFormatException e) {
            return 1;
        }
    }

    /**
     * Returns a random integer that is a suitable value for both the {@code id}
     * and {@code randomNumber} properties of a world object.
     *
     * @return a random world number
     */
    public static int randomWorld() {
        return 1 + ThreadLocalRandom.current().nextInt(10000);
    }

}
