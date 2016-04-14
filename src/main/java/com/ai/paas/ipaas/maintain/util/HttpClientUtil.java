package com.ai.paas.ipaas.maintain.util;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URISyntaxException;
import java.net.URL;

public class HttpClientUtil {
    public static String sendPostRequest(String url, String data) throws IOException, URISyntaxException {
        CloseableHttpClient httpclient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost(new URL(url).toURI());
        StringEntity dataEntity = new StringEntity(data, ContentType.APPLICATION_JSON);
        httpPost.setEntity(dataEntity);
        CloseableHttpResponse response = httpclient.execute(httpPost);
        try {
            if (response.getStatusLine().getStatusCode() == 200) {
                HttpEntity entity = response.getEntity();
                BufferedReader reader = new BufferedReader(new InputStreamReader(entity.getContent()));
                StringBuffer buffer = new StringBuffer();
                String tempStr;
                while ((tempStr = reader.readLine()) != null)
                    buffer.append(tempStr);
                return buffer.toString();
            } else {
                throw new RuntimeException("error code " + response.getStatusLine().getStatusCode());
            }
        } finally {
            response.close();
            httpclient.close();
        }
    }
}
