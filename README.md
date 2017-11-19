HBase in Docker
===============

This configuration builds a docker container to run HBase (with
embedded Zookeeper) running on the files inside the container.

NOTE
----

The approach here requires editing the local server's `/etc/hosts`
file to add an entry for the container hostname.  This is because
HBase uses hostnames to pass connection data back out of the
container (from it's internal Zookeeper).

Hopefully this can be improved with Docker's newer networking
but this hasn't been fixed yet.


Build Image
-----------

    $ docker build -t pippolino/flink_to_hbase .


Pull image
----------

If you want to pull the image already built then use this

    $ docker pull pippolino/flink_to_hbase

More details at https://hub.docker.com/r/pippolino/flink_to_hbase/


Run Image
---------

To run HBase by hand:

    $ docker run --name flink_to_hbase -p 8080:8080 -p 8085:8085 -p 9090:9090 -p 9092: 9092 -p 9095:9095 -p 2181:2181 -p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 -p 6123:6123 -p 7203: 7203 -p 8081:8081 -p 8090:8090 --hostname hbase-docker --add-host hbase-docker:172.17.0.2 pippolino/flink_to_hbase:latest

Connect with bash
---------

For connect to container:

    $ docker exec -it "id of running container" bash
    
Find Hbase status
-----------------

Master status if docker container DNS name is 'hbase-docker'

    http://hbase-docker:16010/master-status

The region servers status pages are linked from the above page.

Thrift UI

    http://hbase-docker:9095/thrift.jsp

REST server UI

    http://hbase-docker:8085/rest.jsp

(Embedded) Zookeeper status

    http://hbase-docker:16010/zk.jsp


See HBase Logs
--------------

If you want to see the latest logs live use:

    $ docker attach $id

Then ^C to detach.

To see all the logs since the HBase server started, use:

    $ docker logs $id

and ^C to detach again.

To see the individual log files without using `docker`, look into
the data volume dir eg $PWD/data/logs if invoked as above.


Proxy HBase UIs locally
-----------------------

If you are running docker on a remote machine, it is handy to see
these server-private urls in a local browser so here is a
~/.ssh/config fragment to do that

    Host my-docker-server
    Hostname 1.2.3.4
        LocalForward 127.0.0.1:16010 127.0.0.1:16010
        LocalForward 127.0.0.1:9095 127.0.0.1:9095
        LocalForward 127.0.0.1:8085 127.0.0.1:8085

When you `ssh my-docker-server` ssh connects to the docker server and
forwards request on your local machine on ports 16010 / 16030 to the
remote ports that are attached to the hbase container.

The bottom line, you can use these URLs to see what's going on:

  * http://localhost:16010/master-status for the Master Server
  * http://localhost:9095/thrift.jsp for the thrift UI
  * http://localhost:8085/rest.jsp for the REST server UI
  * http://localhost:16010/zk.jsp for the embedded Zookeeper

to see what's going on in the container and since both your local
machine and the container are using localhost (aka 127.0.0.1), even
the links work!


Notes
-----

[1] http://happybase.readthedocs.org/en/latest/

[2] https://github.com/wbolster/happybase
"# docker-flink_to_hbase" 
