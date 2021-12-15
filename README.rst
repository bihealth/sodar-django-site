SODAR Django Site
^^^^^^^^^^^^^^^^^

.. image:: https://github.com/bihealth/sodar_django_site/workflows/Build/badge.svg
    :target: https://github.com/bihealth/sodar_django_site/actions?query=workflow%3ABuild

.. image:: https://img.shields.io/badge/License-MIT-yellow.svg
    :target: https://opensource.org/licenses/MIT

This project contains a minimal `Django 3.2 <https://docs.djangoproject.com/en/3.2/>`_
site template for building `SODAR Core <https://github.com/bihealth/sodar_core>`_
based projects.


Introduction
============

The site is based on a site template created with
`cookiecutter-django <https://github.com/pydanny/cookiecutter-django/>`_.

Included in this project are the critical OS and Python requirements, pre-set
Django settings, a pre-installed SODAR Core framework and some helper scripts.
It is also readily compatible with Selenium UI testing, coverage checking and
continuous integration for GitHub Actions and GitLab-CI.

The current version of this site is compatible with
`SODAR Core v0.10.7 <https://github.com/bihealth/sodar_core/tree/v0.10.7>`_.


Installation for Development
============================

For instructions and best practices in Django development, see
`Django 3.2 documentation <https://docs.djangoproject.com/en/3.2/>`_ and
`Two Scoops of Django <https://www.feldroy.com/collections/everything/products/two-scoops-of-django-3-x>`_.

For SODAR Core concepts and instructions, see
`SODAR Core documentation <https://sodar-core.readthedocs.io/>`_.

The examples here use venv and pip, but you may also use e.g. conda for virtual
environments and installing packages.

Requirements
------------

- Ubuntu 20.04 Xenial (Recommended for development)
- Python 3.7+ (3.8 recommended)
- Postgres 9.6+

System Installation
-------------------

First you need to install OS dependencies, PostgreSQL 9.6 and Python3.8.

.. code-block:: console

    $ sudo utility/install_os_dependencies.sh
    $ sudo utility/install_python.sh
    $ sudo utility/install_postgres.sh

Database Setup
--------------

Create a PostgreSQL user and a database for your application. Make sure to
give the user the permission to create further PostgreSQL databases (used for
testing).

You can either use the helper script in ``utility/setup_database.sh`` or use
psql manually. Make sure to replace the example values below with your actual
database name, user name and password.

.. code-block:: console

    $ sudo su - postgres
    $ psql
    $ CREATE DATABASE your_db;
    $ CREATE USER your_user WITH PASSWORD 'your_password';
    $ GRANT ALL PRIVILEGES ON DATABASE your_db to your_user;
    $ ALTER USER your_user CREATEDB;
    $ \q

You have to add the credentials in the environment variable ``DATABASE_URL``.
For development it is recommended to place this variable in an ``.env`` file and
set ``DJANGO_READ_DOT_ENV_FILE=1`` in your actual environment. See
``config/settings/base.py`` for more information.

.. code-block:: console

    DATABASE_URL=postgres://your_user:your_password@127.0.0.1/your_db

Project Setup
-------------

Clone the repository, setup and activate the virtual environment. Once in
the environment, install Python requirements for the project:

.. code-block:: console

    $ git clone https://github.com/bihealth/sodar_django_site.git
    $ cd sodar_django_site
    $ python -m venv .venv
    $ source .venv/bin/activate
    $ utility/install_python_dependencies.sh

**Hint:** At this point, you most likely want to rename the project and the
website directory from ``sodar_django_site`` into the name of the system you
will be developing.

LDAP Setup (Optional)
---------------------

If you will be using LDAP/AD auth on your site, make sure to also run:

.. code-block:: console

    $ sudo utility/install_ldap_dependencies.sh
    $ pip install -r requirements/ldap.txt

Final Setup
-----------

Initialize the database (this will also synchronize django-plugins):

.. code-block:: console

    $ ./manage.py migrate

Create a Django superuser for the web site:

.. code-block:: console

    $ ./manage.py createsuperuser

Retrieve icons to use on the site and collect static files:

.. code-block:: console

    $ ./manage.py geticons
    $ ./manage.py collectstatic

Now you should be able to run the server:

.. code-block:: console

    $ make serve

Navigate to `http://127.0.0.1:8000/ <http://127.0.0.1:8000/>`_ and log in to see
the results. The site should be up and running with the default SODAR Core
layout.

Note that if you are utilizing Celery or the bgjobs app, you will also need to
configure and run Celery in a separate process.


Developing your Site
====================

Once the installation is successful, you can continue to add your own
SODAR based apps. See
`SODAR Core documentation <https://sodar-core.readthedocs.io/>`_.
for further instructions.
