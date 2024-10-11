#!/usr/bin/env sh

################################################################################################
# Copyright (c) 2020 ThermoFisher
# All rights Reserved.
################################################################################################
#$Source: /usr/bin/install-smr.sh,v $
#$Revision: 0.0.1 $
#$Date: 2020/09/18 19:35:40 $
#$Author: arley.wilches $
# Calls these programs:
################################################################################################

ORACLE_URL_ZIP=http://victoria.invitrogen.com/software/oracle/build.zip
ASN2ALL_URL_ZIP=https://ftp.ncbi.nih.gov/asn1-converters/by_program/asn2all/linux64.asn2all.gz

LIBIDN_URL_ZIP=https://raw.githubusercontent.com/thermofisher/magellan-data-refseq-containers/integration/0.0.1-2024.10.43-1.0/victoria/libidn.so.11.6.16

ORACLE_BASIC=oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm
ORACLE_SDK=oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm
ORACLE_SQLPLUS=oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm

if [ "${INSTALL_ORACLE}" -eq "1" ]
then
    curl -fSL "$ORACLE_URL_ZIP" -o /tmp/oracle.zip
    unzip /tmp/oracle.zip -d /
    cd /build/
    alien --scripts /build/$ORACLE_BASIC
    dpkg -i /build/oracle-instantclient11.2-basic_11.2.0.4.0-2_amd64.deb
    alien --scripts /build/$ORACLE_SDK
    dpkg -i /build/oracle-instantclient11.2-devel_11.2.0.4.0-2_amd64.deb
    alien --scripts /build/$ORACLE_SQLPLUS
    dpkg -i /build/oracle-instantclient11.2-sqlplus_11.2.0.4.0-2_amd64.deb
else
    echo "NOTICE: INSTALL_ORACLE is not defined, nothing to install"
fi


if [ "${INSTALL_ASN2ALL}" -eq "1" ]
then

    curl -fSL "$LIBIDN_URL_ZIP" -o /tmp/libidn.so.11.6.16
    cd /tmp/
    mv /tmp/libidn.so.11.6.16 /usr/lib/x86_64-linux-gnu/
    ln -s /usr/lib/x86_64-linux-gnu/libidn.so.11.6.16 /usr/lib/x86_64-linux-gnu/libidn.so.11

    curl -fSL "$ASN2ALL_URL_ZIP" -o /tmp/linux64.asn2all.gz
    cd /tmp/
    gunzip linux64.asn2all.gz
    mv /tmp/linux64.asn2all /usr/bin/asn2all
    chmod +x /usr/bin/asn2all
else
        echo "NOTICE: ASN2ALL_URL_ZIP is not defined, nothing to install"
fi
