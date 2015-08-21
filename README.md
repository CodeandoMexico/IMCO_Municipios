[![Build Status](https://travis-ci.org/civica-digital/mi-negocio-mx.svg?branch=master)](https://travis-ci.org/civica-digital/mi-negocio-mx)
[![Code Climate](https://codeclimate.com/github/civica-digital/mi-negocio-mx/badges/gpa.svg)](https://codeclimate.com/github/civica-digital/mi-negocio-mx)
[![Test Coverage](https://codeclimate.com/github/civica-digital/mi-negocio-mx/badges/coverage.svg)](https://codeclimate.com/github/civica-digital/mi-negocio-mx/coverage)

<img src="http://minegociomexico.mx/images/favicon.ico" alt="Traxi" height="50" width="50"/>Mi Negocio México
===
Es una herramienta que te ayudará a encontrar los trámites y requisitos que debes cumplir para abrir, operar y crecer un negocio en tu municipio. También puedes consultar información sobre inspecciones(Quién y cómo se realizan), crear alertas de las fechas en que debes renovar permisos, hacer denuncias y entender mejor las obligaciones del giro al que pertenece tu empresa.
___

Realizado en [Ruby on Rails](http://rubyonrails.org/) 4.1.1

##Dependencias:

**Amazon [S3 Buckets](http://aws.amazon.com/es/s3/)**: para el guardado de las fotos de los inspectores y documentos que el municipio comparte con empresas.

**Api de [Facebook](https://developers.facebook.com/) y [Linkedin](https://developer.linkedin.com/)**: Es la forma en la que las empresas se registran.

**[Sengrid](https://sendgrid.com/)**: para el manejo de envío de correos.

**[UserVoice](https://www.uservoice.com/)**: Para el manejo de comentarios y retroalimentación.

Se requieren las siguientes llaves:

 
    AMAZON_ACCESS_KEY: 'SOMETHING'
    AMAZON_SECRET_KEY: 'SOMETHING'
    S3_BUCKET: 'SOMETHING'
    AMAZON_REGION: 'SOMETHING'
    gmail_username: 'username@gmail.com'
    gmail_password: 'Gmail password'
    facebook_secret: 'SOMETHING'
    facebook_id: 'SOMETHING'
    linkedin_secret: 'SOMETHING'
    linkedin_id: 'SOMETHING'
    SMTP_CONFIG_USERNAME: 'SOMETHING'
    SMTP_CONFIG_PASSWORD: 'SOMETHING'
    SMTP_CONFIG_DOMAIN: 'SOMETHING'
    SMTP_CONFIG_ADDRESS: 'smtp.SOMETHING'
    ACTION_MAILER_HOST: 'SOMETHING'
    MAILER_DEFAULT_FROM: 'something@mail.com'
    USERVOICE_SUBDOMAIN_NAME: 'SOMETHING'
    USERVOICE_API_KEY: 'SOMETHING'
    USERVOICE_API_SECRET: 'SOMETHING'
    
    
##Instalación:

Puedes acceder al repositorio en [GitHub](https://github.com) de [Mi Negocio México](https://github.com/civica-digital/mi-negocio-mx)

Clonamos el repositorio:

    git clone git@github.com:civica-digital/mi-negocio-mx.git
    
Instalamos y actualizamos las gemas:

	bundle install
	
Creamos las migraciones de la base de datos:

	rake db:create && rake db:migrate 
	
Si queremos llenar la base de datos con la información base de los municipios iniciales:

	rake my_tasks:load_all_data
	
	
##Datasets

Mi Negocio México generó un [estandar de datos](http://estandares.datamx.io/law/555e3c26cc1f420d00ec17bc) el cual consta de 7 datasets:

    Apertura: Trámites federales, municipales y estatales para poder abrir un negocio.
    Dependencias: Listado de dependencias del municipio.
    Giros: Listado de giros existentes en el municipio.
    Inspecciones: Listado de inspecciones que se pueden realizar por giro.
    Inspectores: Listado de inspectores autorizados por el municipio.
    Requisitos: Listado de requisitos que pueden ser pedidos en el municipio.
    Trámites: Trámites para construir, administrar, crecer y financiar o cerrar tu empresa.
    

##¿Preguntas o problemas? 

Mantenemos la conversación del proyecto en nuestra página de problemas [issues](https://github.com/civica-digital/mi-negocio-mx/issues). Si usted tiene cualquier otra pregunta, nos puede contactar por correo a <equipo@civica.digital>.

##Licencia

Licensed under the Apache License, Version 2.0 Read the document [LICENSE](http://www.apache.org/licenses/LICENSE-2.0) for more information

Creado por [Cívica Digital](http://www.civica.digital) y el [Instituto Mexicano para la competitividad](http://imco.org.mx/home/), 2015.

