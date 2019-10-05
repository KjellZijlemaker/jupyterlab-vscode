FROM cyversevice/jupyterlab-base:latest

# apt
RUN apt-get install -y openssl net-tools

# Enable the proxy extension in notebook and lab
RUN conda update -n conda && \
    conda install jupyter-server-proxy -c conda-forge && \
    jupyter labextension install jupyterlab-server-proxy && \
    jupyter lab build

# Download and install VS Code Server
RUN wget -q -O code-server.tar.gz https://github.com/cdr/code-server/releases/download/1.1156-vsc1.33.1/code-server1.1156-vsc1.33.1-linux-x64.tar.gz && \
    mkdir -p ~/.local/bin && \
    tar -xvf code-server.tar.gz -C ~/.local/bin --strip-components=1 && \
    rm -rf code-server.tar.gz

# Install the VS code proxy
RUN pip install .
