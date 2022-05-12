package com.group2.messpeer_client.state;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

import java.util.HashMap;

public class Utils {
    public static class CallState {
        public static final String CALLING = "CALLING";
        public static final String IDLE = "IDLE";
        public static final String TRUE = "TRUE";
        public static final String FALSE = "FALSE";
        public static final String ERROR = "ERROR";
    }

    public static class Json {
        public static String toJson(HashMap<String, String> map) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.putAll(map);
            return jsonObject.toJSONString();
        }

        public static HashMap<String, String> toHashMap(String jsonString) {
            return (HashMap<String, String>) JSONValue.parse(jsonString);
        }
    }
}
