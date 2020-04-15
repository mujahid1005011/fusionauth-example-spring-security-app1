package io.fusionauth.config;

import io.fusionauth.client.FusionAuthClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author Tyler Scott
 */
@Configuration
//@ConfigurationProperties(value = "fusionAuth")
public class FusionAuthClientConfig {

  @Value("${fusionAuth.apiKey}")
  private String apiKey;

  @Value("${fusionAuth.baseUrl}")
  private String baseUrl;

  @Bean
  public FusionAuthClient setupClient() {
    FusionAuthClient client = new FusionAuthClient(apiKey, baseUrl);
    return client;
  }
}
