package com.khulnasoft.ee7.tests;

import java.util.Collections;
import java.util.List;

import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.RequestScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.persistence.EntityManager;

import com.khulnasoft.ee7.model.Fortune;

@RequestScoped
@Named
public class Fortunes {

    private static final int ADDITIONAL_FORTUNE_ID = 0;
    private static final String ADDITIONAL_FORTUNE_CONTENT = "Additional fortune added at request time.";

    @Inject
    private EntityManager em;

    private List<Fortune> data;

    @PostConstruct
    private void postConstruct() {
        data = em.createNamedQuery("allFortunes", Fortune.class).getResultList();
        data.add(new Fortune(ADDITIONAL_FORTUNE_ID, ADDITIONAL_FORTUNE_CONTENT));
        Collections.sort(data);
    }

    public List<Fortune> getData() {
        return data;
    }
}
