package com.example.checkout.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

@Component
public class CheckoutServiceConfiguration {

    @Autowired
    Environment environment;

    public String getCheckoutAmt() {
        return environment.getProperty("checkout.amount");
    }

    public String getProfile() {
        return environment.getProperty("profile");
    }
}
