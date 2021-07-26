<div align="center">
  <img src="https://github.com/domoinc/domo-node-sdk/blob/master/domo.png?raw=true" width="400" height="400"/>
</div>

### Usage:

This code will serve as an example of how to negotiate embedding a Domo dashboard or card in Salesforce via Apex and Visualforce. This is a functioning example including test coverage and so can be deployed to production and utilized with minimal changes, but it is recommended that you customize to add filtering, error handling, token storage, and any other desried enhancements.

### Don't forget:

Modify the "domoEmbedExampleController" to populate the 4 variables correctly at the top.

Add "https://api.domo.com" to your Remote Site Settings.

Add to lightning layouts using the Visualforce component type.
and/or
Add to existing Lightning Web Components or Visualforce pages with an iframe.