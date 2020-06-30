package com.example.cart.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

@Component
public class CartServiceConfiguration {

    @Autowired
    Environment environment;

    public String getGlobalProfile() {
        return environment.getProperty("global.profile");
    }

    public String getUserCartItems() {
        return environment.getProperty("user.cart.items");
    }

    public String getUserCartRate() {
        return environment.getProperty("user.cart.rate");
    }

    public String getProfile() {
        return environment.getProperty("profile");
    }



}
