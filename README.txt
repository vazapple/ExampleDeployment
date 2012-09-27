Example Deployment
------------------

This is designed to be a standalone template project containing everything
required to produce a package which can be deployed and run as an OpenGamma
server. This should be a starting point for custom OpenGamma deployments.

The project is Maven-based and depends on the OpenGamma public Maven repository
included in pom.xml. To build the deployment package, simply run

  mvn package
  
This generates the package in potentially multiple formats in the target
directory. These are named exampledeployment-[version]-[assembly-id].[ext], e.g.
exampledeployment-0.0.1-SNAPSHOT-server.tar.bz2.
