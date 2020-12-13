FROM python:alpine3.12

RUN apk update && apk upgrade && apk add openssh vim nano gcc musl-dev libc-dev libc6-compat linux-headers build-base git libffi-dev openssl-dev graphviz graphviz-dev

WORKDIR /root/workspace/

RUN git clone https://github.com/datacenter/webarya.git
RUN git clone https://github.com/bit-git/alpine-python-aci.git
RUN python -m pip install -r alpine-python-aci/requirements.txt

RUN git clone https://github.com/datacenter/acitoolkit.git
RUN cd acitoolkit && python setup.py install

RUN wget https://d1nmyq4gcgsfi5.cloudfront.net/fileMedia/1f3d41ce-d154-44e3-74c1-d6cf3b525eaa/acicobra-4.2_3h-py2.py3-none-any.whl \
&& pip install acicobra-4.2_3h-py2.py3-none-any.whl
RUN wget https://d1nmyq4gcgsfi5.cloudfront.net/fileMedia/b3b69aa3-891b-41ff-46db-a73b4b215860/acimodel-4.2_3h-py2.py3-none-any.whl \
&& pip install acimodel-4.2_3h-py2.py3-none-any.whl

RUN rm -r /root/workspace/alpine-python-aci
RUN rm acicobra-4.2_3h-py2.py3-none-any.whl
RUN rm acimodel-4.2_3h-py2.py3-none-any.whl
CMD ["sh"]

