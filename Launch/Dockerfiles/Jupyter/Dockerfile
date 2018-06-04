FROM spark-img:latest

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    nodejs npm ca-certificates musl-dev gcc python-dev make cmake g++ gfortran libpng-dev libxml2-dev libxslt-dev \
    krb5-config libkrb5-dev libssl-dev libsasl2-dev libsasl2-modules-gssapi-mit \
    && apt-get purge \
    && apt-get clean

RUN add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y python3.6 python3-pip python-dev build-essential \
    && python3 -m pip install jupyter jupyterlab ipykernel pyspark findspark sparkmagic \
    && python3 -m ipykernel install --user \
    && apt-get purge \
    && apt-get clean \
    && mkdir -p /opt/app/data

RUN mkdir ~/.sparkmagic \
  && jupyter nbextension enable --py --sys-prefix widgetsnbextension \
  && jupyter-kernelspec install --user $(pip3 show sparkmagic | grep Location | cut -d" " -f2)/sparkmagic/kernels/sparkkernel \
  && jupyter-kernelspec install --user $(pip3 show sparkmagic | grep Location | cut -d" " -f2)/sparkmagic/kernels/pysparkkernel \
  && jupyter-kernelspec install --user $(pip3 show sparkmagic | grep Location | cut -d" " -f2)/sparkmagic/kernels/sparkrkernel \
  && jupyter serverextension enable --py sparkmagic \
  && jupyter labextension install @jupyter-widgets/jupyterlab-manager

ADD config.json /root/.sparkmagic/config.json

# install via file requirements.txt
RUN pip3 install pandas==0.22.0

# RUN pip install toree
# RUN jupyter toree install --spark_home=/opt/spark/

EXPOSE 8888

CMD ["jupyter", "lab","--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser", "--notebook-dir=/opt/app/data", "--NotebookApp.token=''"]
