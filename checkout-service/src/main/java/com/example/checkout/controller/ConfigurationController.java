package com.example.checkout.controller;

import com.example.checkout.configuration.CheckoutServiceConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ConfigurationController {

    @Autowired
    CheckoutServiceConfiguration checkoutServiceConfiguration;

    @RequestMapping("/config")
    public CheckoutServiceConfiguration getConfig() {
        return checkoutServiceConfiguration;
    }

}
