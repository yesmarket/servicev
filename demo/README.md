# Galaxy.Identity - API Mocks

## overview

Provides a quick an easy way to provision a local or public mock of the auth service, which is required by Azure AD B2C for the JIT user migration.

## tooling pre-requisites

* [git](https://git-scm.com/downloads)
* [docker](https://www.docker.com/get-started)
* [git-crypt](https://github.com/AGWA/git-crypt)
* [node.js/npm](https://nodejs.org/en/)
* [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-6)

## usage

* To build the ServiceV docker image; `npm run build`
* To start a local virtual service; `npm run start`
* To stop a local virtual service; `npm run stop`
* If you or one of your colleagues makes changes to the virtual service in ServiceV; `npm run refresh`
* To publish the virtual service to a centralised VirtServer; `npm run publish`
* To exec into the container running ServiceV; `npm run debug`

## testing

Once you've got ServiceV running in a container, you can test it's working by running the following curl statments;
`curl -X POST 'http://localhost:8089/b2c/api/v1/auth' -d 'username=good&password=test'` will return HTTP 200.
`curl -X POST 'http://localhost:8089/b2c/api/v1/auth' -d 'username=bad&password=test'` will return HTTP 409 - see [returning error message](https://docs.microsoft.com/bs-latn-ba/azure/active-directory-b2c/restful-technical-profile#returning-error-message)s for more information.

## additional references

You don't _need_ to use the following tools to run the mock service, but if you intend on making changes to the OAS or the virtual service, then you might need to dig into the following:

* [SwaggerHub](https://app.swaggerhub.com/home)
* [ServiceV](https://support.smartbear.com/readyapi/docs/servicev/index.html)
* [VirtServer](https://support.smartbear.com/readyapi/docs/virtserver/index.html)
