<%@ page import="java.util.Enumeration" %>
<%@ page import="com.google.appengine.repackaged.org.apache.commons.codec.binary.Base64" %>
<%@ page import="com.google.appengine.repackaged.com.google.gson.Gson" %>
<%@ page import="com.google.appengine.repackaged.com.google.gson.JsonElement" %>

<%--
  Created by IntelliJ IDEA.
  User: aerin
  Date: 16.10.2015
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
/*
  Enumeration enum1 = request.getParameterNames();
  while( enum1.hasMoreElements() )
  {
  String name = (String)enum1.nextElement();
  String value = request.getParameter(name).toString();
  out.println( "Name = " + name + ". Value = " + value );
  }
*/
%>
<%
    class Age
    {
        public int Min;
    }

    class User
    {
        public String country;
        public String locale;
        public Age age;
        public String user_id;
    }

    class FBLogin
    {
        public String algorithm;
        public int expires;
        public int issued_at;
        public String oauth_token;
        public User user;
    }

    //parse signed_request
    if(request.getParameter("signed_request") != null)
    {

        //it is important to enable url-safe mode for Base64 encoder
        Base64 base64 = new Base64(true);

        //split request into signature and data
        String[] signedRequest = request.getParameter("signed_request").split("\\.", 2);

        //parse signature
        String sig = new String(base64.decode(signedRequest[0].getBytes("UTF-8")));

        //parse data and convert to json object
        Gson gson = new Gson();

        out.println( new String(base64.decode(signedRequest[1].getBytes("UTF-8"))) );

        String test = "{\"algorithm\":\"HMAC-SHA256\",\"expires\":1445022000,\"issued_at\":1445017960,\"oauth_token\":\"CAACgG5O1ZCaUBAMAaPH2SeB3c8jL3tn9RW7tlDlW1NA7XfwQxnqiZCWdY1RH5GRkhscnVRpuH2hDbr4LPN9xAUnZBvOKi4BeZBZAyqyTYTg1Mf2LAddZA9X9gg0ZBiCXZAizwKDLeMdAEv6rZCUPOMsQYfOZBnoaXN6aznjuZAbZBdkVepLX4WyTFndJM6mZBpHmlSvaoMAOYOZC8Q1gZDZD\",\"user\":{\"country\":\"ru\",\"locale\":\"ru_RU\",\"age\":{\"min\":21}},\"user_id\":\"891336827616591\"}";

        FBLogin login = gson.fromJson( test, FBLogin.class );

    //JSONArray jsonarray = new JSONArray();

//        JsonElement[] data = gson.fromJson(new String(base64.decode(signedRequest[1].getBytes("UTF-8"))), JsonElement[].class);
        /*
        for( String item:data)
        {
            out.println( "* " + item );
        }
        //JSONObject data = (JSONObject)JSONSerializer.toJSON(new String(base64.decode(signedRequest[1].getBytes("UTF-8"))));
*/
    }
%>
</body>
</html>
