Тестовое задание выполнено с применением Vagrant и Ansible. Решение содержит один Vagrantfile, в котором описаны виртуальные машины под управлением ОС centos 7 (box generic/centos7, был выбран, в том числе, из-за наличия libvirt версии, так как это решение не требующее сторонних пакетов на гипервизоре). 

Установка необходимых пакетов, а также их настройка, выполняется автоматически, при помощи Ansible. Для этого написано 3 playbook -- по одной для каждого типа (роли) серверов. Плейбуки запускаются автоматически, средствами Vagrant, после резвертывания виртуальных машин.

В роли балансировщика нагрузки выбран HAProxy, сконфигурированный для распределения нагрузки на два сервера приложения, методом Round-Robin. Обращение возможно только с указанием доменного имени -- app.local (на выделенной для выполнения задания виртуальной машине добавлен в /etc/hosts). 

В качестве сервера приложения выступает лёгкий веб-сервер на Python -- Flask, это решение выбрано исключительно в демонстрационных целях. Код приложения найден на одном из интернет ресурсов по Python и незначительно переработан. Загрузка файлов приложения, установка необходимых пакетов, а также генерация .env файла для Python, с указанием данных для доступа к БД осуществляется посредством Ansible. Приложение отвечает на GET-запрос к tcp-порту 5000, доступ к которому разрешен только с адреса балансировщика (посредством iptables). Конечная точка /items .

СУБД выбрана mariadb, файлы конфигурации оставлены без изменений. База данных, пользователь с ограниченными правами (доступ только к одной таблице БД), а также демо-данные создаются выполнением запросов из sql-файла. Доступ анонимным пользователям не разрешается. Правилами iptables разрешены запросы к БД только с адресов серверов приложенрия.

Vagrantfile:

В начале файла описана массив backends, в нём перечисляются серверы приложения, каждый из которых будет развёрнут с указанными данными и внесён во все необходимые списки доступов. Массив app_nodes нужен для правильной работы ansible-плейбука, и заполнится автоматически.

Чтобы запустить проект выполните команды:

git clone https://github.com/DermanskIIII/vagrant-test-1.git
cd vagrant-test-1
vagrant up

Добавьте в ваш /etc/hosts файл (%WINDIR%\system32\drivers\etc\hosts в ОС семейства Windows) строку

127.0.0.1 app.local

После завершения всех процедур запуска и конфигурирования машин выполните команду

curl app.local:5000/items

результатом её будет отображение json содержащего записи БД, а также, последней строкой, адрес ответившей ноды приложения.