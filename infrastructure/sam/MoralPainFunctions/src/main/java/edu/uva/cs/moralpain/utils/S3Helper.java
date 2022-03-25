package edu.uva.cs.moralpain.utils;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.AwsCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.http.urlconnection.UrlConnectionHttpClient;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.S3ClientBuilder;
import software.amazon.awssdk.utils.AttributeMap;

import java.net.URI;
import java.time.Instant;
import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import static software.amazon.awssdk.http.SdkHttpConfigurationOption.TRUST_ALL_CERTIFICATES;

public class S3Helper {

    /**
     * An S3 Client parameterized by the environment.
     * @param variableManager
     * @return
     */
    public static S3Client createS3Client(VariableManager variableManager) {
        String region = variableManager.getOrDefault("region", "us-east-1");

        // TODO (nphair): Do not blindly trust everything. Figure out how to trust only our mocked endpoint.
        S3ClientBuilder builder = S3Client.builder()
                .region(Region.of(region))
                .httpClient(UrlConnectionHttpClient.builder().buildWithDefaults(AttributeMap.builder()
                        .put(TRUST_ALL_CERTIFICATES, Boolean.TRUE)
                        .build()));

        if(variableManager.containsKey("overrideEndpoint")) {
            builder.endpointOverride(URI.create(variableManager.get("overrideEndpoint")));
        }

        if(variableManager.containsKey("accessKeyId") && variableManager.containsKey("secretAccessKey"))  {
            String accessKeyId = variableManager.get("accessKeyId");
            String secretAccessKey = variableManager.get("secretAccessKey");
            AwsCredentials credentials = AwsBasicCredentials.create(accessKeyId, secretAccessKey);
            builder.credentialsProvider(StaticCredentialsProvider.create(credentials));
        }

        return builder.build();
    }

    /**
     * Create a key that is composed of the current time and a uuid.
     * @return the key
     */
    public static String createKey() {
        Instant now = Instant.now();
        DateTimeFormatter formatter = DateTimeFormatter
                .ofPattern("y/MM/dd/HH/mm/ss")
                .withZone(ZoneId.from(ZoneOffset.UTC));
        String uuid = UUID.randomUUID().toString().replace("-", "");
        return formatter.format(now) + "/" + uuid + ".json";
    }

}
