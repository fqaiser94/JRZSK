# Status

spark master launches  
spark worker launches  
spark master is able to connect to workers  

livy launches  
livy can connect to spark-master  

rstudio launches  
rstudio can connect to spark-master through livy (only on GKE)  

jupyter lab launches  
jupyter lab launches  
jupyter lab can connect to spark-master through pyspark (only on GKE)  
jupyter lab can connect to spark-master through sparkmagic (only on GKE)  
jupyter lab can connect to spark-master through sparkmagic kernels   (PySpark, Spark, SparkR, only on GKE)  

zeppelin launches  
zeppelin can connect to spark-master (only on GKE)  

![Image of Spark UI](/Images/Spark-ui.png | width="100")
![Image of Livy UI](/Images/Livy.png | width="100")
![Image of RStudio](/Images/RStudio.png | width="100")
![Image of JupyterLab](/Images/JupyterLab.png | width="100")
![Image of Zeppelin](/Images/Zeppelin.png | width="100")
<!-- ![Image of spark-shell](https://octodex.github.com/images/yaktocat.png)
![Image of pyspark](https://octodex.github.com/images/yaktocat.png)
![Image of sparkR](https://octodex.github.com/images/yaktocat.png)
![Image of bash](https://octodex.github.com/images/yaktocat.png) -->

# Lessons learned:

1. Need to have same python version on all nodes
2. Need to have same spark version on all nodes
3. Be careful when using minikube docker daemon and local docker daemon in same terminal session.
4. "Starting with version 0.5.0-incubating, session kind “pyspark3” is removed, instead users require to set PYSPARK_PYTHON to python3 executable." - livy website

# Fixes to be made

1. Clean up code  
e.g. switch to deployments instead of rc  
e.g. pass spark_ver programmatically to all files  
e.g. build own rstudio image  
e.g. add ability to define what UIs you want to minimize pods running  
e.g. clean up YAMLs, selector crap  
e.g. spark-ui-proxy-controller  
e.g. write a python client to interactively control containers like I want a zeppelin container now  
2. Include example notebooks  
3. Add Google Drive / GitHub integration to JupyterLab
4. Upgrade to Spark 2.3 and try experimental kubernetes support
https://spark.apache.org/docs/2.3.0/running-on-kubernetes.html
5. Implement Apache Toree using this tutorial https://blog.thedataincubator.com/2017/04/spark-2-0-on-jupyter-with-toree/
6. Testing jupyter notebooks
https://blog.thedataincubator.com/2016/06/testing-jupyter-notebooks/
7. set resource limits and shtuff

# Links to useful material

1. Great blog series on deploying spark on kubernetes:
http://blog.madhukaraphatak.com/scaling-spark-with-kubernetes-part-1/
2. Spark dockerfile sourced mostly from here:
https://github.com/eBay/Kubernetes/blob/master/examples/spark/images/base/Dockerfile
3. Spark-ui-proxy dockerfile sourced mostly from here:
https://github.com/aseigneurin/spark-ui-proxy
