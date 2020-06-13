package com.example.productservice.controller;

import com.example.productservice.configuration.ProductServiceConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ConfigurationController {

    @Autowired
    ProductServiceConfiguration productServiceConfiguration;

    @RequestMapping("/config")
    public ProductServiceConfiguration getConfig() {
        return productServiceConfiguration;
    }
}
