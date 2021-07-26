public class domoEmbedExampleController {

    /////////////////////////////////////////////////////////////
    //   Input / Output
    /////////////////////////////////////////////////////////////

    // these would ideally not be hard-coded but stored in custom settings or metadata
    // or I like to store them in two encrypted fields on the user who generated them
    private final String client_id = '[ ENTER YOUR CLIENT ID HERE ]';
    private final String client_secret = '[ ENTER YOUR CLIENT SECRET HERE ]';

    // this ID is NOT the one you can see in the URL of the Domo instance
    // it is the 5-character embed ID you can only copy from the embed dialog for that card or dashboard
    public String embed_id { get{return '[ ENTER YOUR EMBED ID HERE ]';}}
    
    // code needs to know what you are embedding, set this to either "card" or "dashboard"
    public String embed_type { get{return '[ DECLARE "card" OR "dashboard" HERE ]';}}

    // this is the ultimate output, the token which the page will use to be able to access the embedded content
    public String embedToken {get;set;}



    // constructor
    public domoEmbedExampleController() {

        /////////////////////////////////////////////////////////////
        //   STEP 1: Authorize using client ID and secret
        /////////////////////////////////////////////////////////////
        
        // don't forget to add api.domo.com to your remote site settings
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.domo.com/oauth/token?grant_type=client_credentials&scope=data%20audit%20user%20dashboard');
        req.setMethod('POST');

        // basic authorization header
        Blob headerValue = Blob.valueOf(client_id + ':' + client_secret);
        String authorizationHeader = 'Basic ' +
        EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);

        // send the request
        Http http = new Http();
        HttpResponse res = http.send(req);

        // strip out our access_token
        Map<String, Object> resMap =(Map<String, Object>)JSON.deserializeUntyped(res.getBody());
        String token = String.valueOf(resMap.get('access_token'));

        // you may wish to do some error handling with the status
        system.debug(res.getStatusCode() + ': ' + res.getStatus());

        /////////////////////////////////////////////////////////////
        //   STEP 2: Embed authentication and possible filtering
        /////////////////////////////////////////////////////////////

        HttpRequest req2 = new HttpRequest();
        if(embed_type!='card')
            req2.setEndpoint('https://api.domo.com/v1/stories/embed/auth');
        else
            req2.setEndpoint('https://api.domo.com/v1/cards/embed/auth');
        req2.setMethod('POST');

        // this time we send our token from above for authorization
        req2.setHeader('Authorization', 'bearer ' + token);
        req2.setHeader('Content-Type', 'application/json');

        // the body will be JSON, this is a super simple example. For more on this including how to filter
        // visit: https://developer.domo.com/docs/embed-token-api-reference/embed-token-api-reference
        // also, Apex has a JSON class that is helpful if you want to store filters in apex objects and
        // convert to JSON easily: https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_class_System_Json.htm
        String payload = '{"sessionLength": 1440, "authorizations" :[{"token" : "' + embed_id + '","permissions" : ["READ", "FILTER", "EXPORT"]}]}';
        req2.setBody(payload);

        // make the call
        http = new Http();
        HttpResponse res2 = http.send(req2);
        
        // again, may want to check the status and handle failure
        system.debug(res2.getStatusCode() + ': ' + res2.getStatus());
        system.debug(res2.getBody());

        // we pull out our token (yay)
        resMap = (Map<String, Object>)JSON.deserializeUntyped(res2.getBody());
        embedToken = String.valueOf(resMap.get('authentication'));

        // note: the original token and embedToken can both be stored and reused until they are expired
        // for example you could store them in platform cache if desired:
        // https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_cache_namespace_overview.htm
    }
}