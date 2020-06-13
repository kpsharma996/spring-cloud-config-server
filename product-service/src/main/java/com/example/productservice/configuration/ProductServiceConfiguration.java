package com.example.productservice.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

@Component
public class ProductServiceConfiguration {

    @Autowired
    Environment environment;

    public String getProdQty() {
        return environment.getProperty("products.qty");
    }

    public String getProfile() {
        return environment.getProperty("profile");
    }

}
