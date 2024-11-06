package com.khulnasoft.benchmark.pippo.dao;

import com.khulnasoft.benchmark.pippo.model.Fortune;
import com.khulnasoft.benchmark.pippo.model.World;

import java.util.List;

public interface Dao extends AutoCloseable {

	World getRandomWorld();

	List<World> getRandomWorlds(int count);

	void updateRandomWorlds(List<World> model);

	List<Fortune> getFortunes();

}
