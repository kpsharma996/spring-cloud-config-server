package com.example.cart.controller;

import com.example.cart.configuration.CartServiceConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ConfigurationController {

    @Autowired
    CartServiceConfiguration cartServiceConfiguration;

    @RequestMapping("/config")
    public CartServiceConfiguration getConfig() {
        return cartServiceConfiguration;
    }

}
