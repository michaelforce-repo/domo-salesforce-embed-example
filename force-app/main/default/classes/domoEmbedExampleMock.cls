@isTest
global class domoEmbedExampleMock implements HttpCalloutMock {

    global HTTPResponse respond(HTTPRequest req) {
        
        HttpResponse res = new HttpResponse();
        
        // this will return a mock response for authentication requests
        if(req.getEndpoint().contains('token')){
        	res.setHeader('Content-Type', 'application/json');
        	res.setBody('{"access_token": "thisisfaketoken.eyJzY29wZSI6WyJkYXRhIl0sImV4cCI6MTQ1NTAwNTExNSwiZW52IjoibG9jYWwiLCJ1c2VySWQiOjExMjkyMDMyOTUsImp0aSI6IjVlMDRkZDc5LTBiNjUtNDc5OC1iNjdmLWQzY2JhM2I3OTUwMCIsImNsaWVudF9pZCI6IjJiNmI1M2RmLTYyODgtNDFmYy04ZGIwLTI4Y2NhNzc3OThjYSIsImN1c3RvbWVyIjoiZGV2In0.PzlEy7MuEkp_AzJYbKzm4WskLE2aZ1Ge-CleO_FV9sz76NqOXjff-FvHCy83hBu4fWt1kRszPjelNj5Sq3h2aEY486dhbGGcVIarm6","expires_in": 3599,"scope": "data","token_type": "bearer"}');
        	res.setStatusCode(200);
        }
        // this will be the response for embed token requests
        else if(req.getEndpoint().contains('embed')){
        	res.setHeader('Content-Type', 'application/json');
        	res.setBody('{"authentication" : "thisisafakeauthenticationhbGciOiJIUzI1NiJ9.eyJzdWIiOiI0MDAxOTY1NCIsIm5iZiI6MTU3OTY0NjE2NCwiaXNzIjoiYXB2F0ZXdheSIsImVtYiI6WyJ7XCJ0b2tlblwiOlwiYnFvN2VcIixcImxpbmtUeXBlXCI6XCJTRUFSQ0hBQkxFXCIsXCJwZXJtaXNzaW9uc1wiOltcIlJFQURcIl19Il0sII6MTU3OTY3NDk3NCwiaWF0Ir5h3joxNTc5NjQ2MTc0LCJqdGkiOiI3MTBwODRmMy094n2S3FmLTRjZWUtYTczZC00ZmNjMWU4OTViZmQifQ.ET0s7o49vLvj2MUwOALfayR7_vzEIMn5TRoTjq3TPo"}');
        	res.setStatusCode(200);
        }
        
        return res;
    }
}