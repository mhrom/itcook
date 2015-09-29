-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: itcook
-- ------------------------------------------------------
-- Server version	5.5.40-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `articles_article`
--

DROP TABLE IF EXISTS `articles_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articles_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content_markdown` longtext NOT NULL,
  `content_markup` longtext NOT NULL,
  `date_publish` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles_article`
--

LOCK TABLES `articles_article` WRITE;
/*!40000 ALTER TABLE `articles_article` DISABLE KEYS */;
INSERT INTO `articles_article` VALUES (3,'sed, a stream editor','sed-stream-editor','Sed потоковий редактор тексту. Потоковий редактор використовується для елементарного перетворення тексту з вхідного потоку або файлу на стандартний вихід, або перенаправлення в файл. Може працювати, імітувати роботу таких лінукс, юнікс інструментів для обробки тексту, як head, tail, cat, wc.\r\n\r\nНижче наведені приклади використання потокового редактору, і синтаксис команд.\r\n\r\nЗадача: \r\nПідрахувати кількість стрічок в файлі, тобто емуляція команди wc -l.  \r\n\r\nРішення:\r\n**sed -ne \'$=\' /etc/network/interfaces**\r\n\r\n*root@itcook:~# sed -ne \'$=\' /etc/network/interfaces   \r\n16*\r\n\r\nОбговорення:\r\nВ команді вище потоковий редактор считує лінію за лінією з файла /etc/network/interfaces, в одинарних кавичках, Ви можете побачити символ кінця стрічки **$**, знак дорівнює заставляє сумувати кількість стрічок, опція **-n** подавляє вивід на стандартний потік тексту з файлу. В мене під сервером убунтою получилося 16 стрічок, для провірки можете підрахувати з допомою команди **wc -l**.\r\n\r\nЗадача:\r\nВідобразити на екран останніх 20 записів про роботу веб-сервера і спеціалізованого прикладного сервера, наприклад **nginx+uwsgi**, **nginx+php-fpm**.\r\n\r\nРішення:\r\n\r\n**echo \'Nginx error log\' && sed -e :a -e \'$q;N;21,$D;ba\' /var/log/nginx/itcook.error.log**\r\n\r\n**echo \'Uwsgi error log\' && sed -e :a -e \'$q;N;21,$D;ba\' /var/log/uwsgi/app/itcook.log**\r\n\r\n*Nginx error log\r\n2014/11/29 17:12:02 [error] 627#0: *3865 open() \"/var/www/python/itcook/static/css/bootstrap-responsive.min.css\" failed (2: No such file or directory), client: 192.168.255.254, server: itcook.kiev.ua, request: \"GET /static/css/bootstrap-responsive.min.css HTTP/1.1\", host: \"itcook.kiev.ua\", referrer: \"http://itcook.kiev.ua/programming/\"*\r\n\r\n*Uwsgi error log\r\n[pid: 30355|app: 0|req: 65/120] 192.168.255.254 () {44 vars in 789 bytes} [Sat Nov 29 20:09:52 2014] GET /favicon.ico => generated 3450 bytes in 16 msecs (HTTP/1.0 404) 2 headers in 80 bytes (1 switches on core 0)*\r\n\r\nОбговорення: \r\nЯкщо Ви замітили, я для зручності добавив стрічки із кодом з пункту рішення в файл parser.sh i добавив alias в файл .bashrc керування системною облочкою. Скоріше за все ви знаєте, що кожний раз при вході в багатокористувацький режим, облочка, в нашому випадку bash, витягую змінні оточення, конфігурацію термінала, і скоречення alias в форматі alias **variable = command1 arg1 arg2**,  і при потребі моніторингу роботи серверів, я запускаю alias з іменем web_log, який вказує на скрипт parser.sh. Для наглядності я вставив вище вивід із термінала сервера. Тобто в даному випадку **sed** емулює роботу програми **tail**. Можливо мінус в тому, що потрібно перезапускати скрипт parser.sh, коли **tail -F**  постоянно моніторить надходження нових даних в файл логів. Так ми трішки відхилилися від основної теми, що саме робить sed в даній ситуації. \r\nПотоковий редактор sed вміє працювати із мітками, **a** це наша мітка, опція **-e** вказує, що набір фільтрів задається із командної облочки, відмітимо, можу бути також із файлу, опція **-f**.\r\nНаступна частина фільтру, **$** - адрес отсанньої стрічки у файлі, команда **q** прининяє читання даних із файлу і передає управління команді **N**, яка копіює стрічку в виділуну память, так звану pattern space. Щоб було зрозуміло sed оперує двома шматками виділеної памяті pattern space і hold space, і використовує функції, які дозволяють керувати обміном між цими буферами памяті **H, h, G, g**. Так от команда **N** дозволяє скопіювати останню стрічку в буфер pattern space. Тобто остання стрічка стає першою, процес повторюється, стрічки з 21, по останню(тобто та ще перша в файлі, видаляються), мітка не спрацьовує, дані на стандартний вхід не подуються, з буфера памяті pattern space виводяться 20 стрічок на стандартний вивід, тобто термінал, в нашому випадку монітор ноутбука.','<p>Sed потоковий редактор тексту. Потоковий редактор використовується для елементарного перетворення тексту з вхідного потоку або файлу на стандартний вихід, або перенаправлення в файл. Може працювати, імітувати роботу таких лінукс, юнікс інструментів для обробки тексту, як head, tail, cat, wc.</p>\n<p>Нижче наведені приклади використання потокового редактору, і синтаксис команд.</p>\n<p>Задача: \nПідрахувати кількість стрічок в файлі, тобто емуляція команди wc -l.  </p>\n<p>Рішення:\n<strong>sed -ne \'$=\' /etc/network/interfaces</strong></p>\n<p><em>root@itcook:~# sed -ne \'$=\' /etc/network/interfaces <br />\n16</em></p>\n<p>Обговорення:\nВ команді вище потоковий редактор считує лінію за лінією з файла /etc/network/interfaces, в одинарних кавичках, Ви можете побачити символ кінця стрічки <strong>$</strong>, знак дорівнює заставляє сумувати кількість стрічок, опція <strong>-n</strong> подавляє вивід на стандартний потік тексту з файлу. В мене під сервером убунтою получилося 16 стрічок, для провірки можете підрахувати з допомою команди <strong>wc -l</strong>.</p>\n<p>Задача:\nВідобразити на екран останніх 20 записів про роботу веб-сервера і спеціалізованого прикладного сервера, наприклад <strong>nginx+uwsgi</strong>, <strong>nginx+php-fpm</strong>.</p>\n<p>Рішення:</p>\n<p><strong>echo \'Nginx error log\' &amp;&amp; sed -e :a -e \'$q;N;21,$D;ba\' /var/log/nginx/itcook.error.log</strong></p>\n<p><strong>echo \'Uwsgi error log\' &amp;&amp; sed -e :a -e \'$q;N;21,$D;ba\' /var/log/uwsgi/app/itcook.log</strong></p>\n<p><em>Nginx error log\n2014/11/29 17:12:02 [error] 627#0: </em>3865 open() \"/var/www/python/itcook/static/css/bootstrap-responsive.min.css\" failed (2: No such file or directory), client: 192.168.255.254, server: itcook.kiev.ua, request: \"GET /static/css/bootstrap-responsive.min.css HTTP/1.1\", host: \"itcook.kiev.ua\", referrer: \"http://itcook.kiev.ua/programming/\"*</p>\n<p><em>Uwsgi error log\n[pid: 30355|app: 0|req: 65/120] 192.168.255.254 () {44 vars in 789 bytes} [Sat Nov 29 20:09:52 2014] GET /favicon.ico =&gt; generated 3450 bytes in 16 msecs (HTTP/1.0 404) 2 headers in 80 bytes (1 switches on core 0)</em></p>\n<p>Обговорення: \nЯкщо Ви замітили, я для зручності добавив стрічки із кодом з пункту рішення в файл parser.sh i добавив alias в файл .bashrc керування системною облочкою. Скоріше за все ви знаєте, що кожний раз при вході в багатокористувацький режим, облочка, в нашому випадку bash, витягую змінні оточення, конфігурацію термінала, і скоречення alias в форматі alias <strong>variable = command1 arg1 arg2</strong>,  і при потребі моніторингу роботи серверів, я запускаю alias з іменем web_log, який вказує на скрипт parser.sh. Для наглядності я вставив вище вивід із термінала сервера. Тобто в даному випадку <strong>sed</strong> емулює роботу програми <strong>tail</strong>. Можливо мінус в тому, що потрібно перезапускати скрипт parser.sh, коли <strong>tail -F</strong>  постоянно моніторить надходження нових даних в файл логів. Так ми трішки відхилилися від основної теми, що саме робить sed в даній ситуації. \nПотоковий редактор sed вміє працювати із мітками, <strong>a</strong> це наша мітка, опція <strong>-e</strong> вказує, що набір фільтрів задається із командної облочки, відмітимо, можу бути також із файлу, опція <strong>-f</strong>.\nНаступна частина фільтру, <strong>$</strong> - адрес отсанньої стрічки у файлі, команда <strong>q</strong> прининяє читання даних із файлу і передає управління команді <strong>N</strong>, яка копіює стрічку в виділуну память, так звану pattern space. Щоб було зрозуміло sed оперує двома шматками виділеної памяті pattern space і hold space, і використовує функції, які дозволяють керувати обміном між цими буферами памяті <strong>H, h, G, g</strong>. Так от команда <strong>N</strong> дозволяє скопіювати останню стрічку в буфер pattern space. Тобто остання стрічка стає першою, процес повторюється, стрічки з 21, по останню(тобто та ще перша в файлі, видаляються), мітка не спрацьовує, дані на стандартний вхід не подуються, з буфера памяті pattern space виводяться 20 стрічок на стандартний вивід, тобто термінал, в нашому випадку монітор ноутбука.</p>','2014-11-24 15:19:02'),(4,'chef-solo','chef-solo','Chef-solo - це продукт для автоматичного встановлення, конфігурування середовища для розробки, платформи, веб-сервера, клієнтської машини. \r\n\r\nНа відміну від клієнт-серверної версії chef, chef-solo не підключається до централізованого репозитарія із інструкціями для встановлення ПО, і конфігурації сервісів, добавлення користувачів, публічних rsa, dsa ключів, сценаріїв, встановлення пакетів, створення додаткових файлів і конфігурацій, все це він роботь локально, считує файл налашутвання, і кукбуки, та налаштовує оточення. Кукбуки - це інструкції за допомогою яких, локально відбувається налашутвання сервера, змінних отчення, створення додаткових файлів.\r\n\r\nЗадача: Налаштувати два веб сервера за допомогою chef-solo.','<p>Chef-solo - це продукт для автоматичного встановлення, конфігурування середовища для розробки, платформи, веб-сервера, клієнтської машини. </p>\n<p>На відміну від клієнт-серверної версії chef, chef-solo не підключається до централізованого репозитарія із інструкціями для встановлення ПО, і конфігурації сервісів, добавлення користувачів, публічних rsa, dsa ключів, сценаріїв, встановлення пакетів, створення додаткових файлів і конфігурацій, все це він роботь локально, считує файл налашутвання, і кукбуки, та налаштовує оточення. Кукбуки - це інструкції за допомогою яких, локально відбувається налашутвання сервера, змінних отчення, створення додаткових файлів.</p>\n<p>Задача: Налаштувати два веб сервера за допомогою chef-solo.</p>','2014-11-29 22:08:20'),(5,'test','test','network','<p>network</p>','2014-12-13 16:02:50');
/*!40000 ALTER TABLE `articles_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articles_article_categories`
--

DROP TABLE IF EXISTS `articles_article_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articles_article_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_id` (`article_id`,`category_id`),
  KEY `articles_article_categories_e669cc35` (`article_id`),
  KEY `articles_article_categories_6f33f001` (`category_id`),
  CONSTRAINT `article_id_refs_id_e4484e23` FOREIGN KEY (`article_id`) REFERENCES `articles_article` (`id`),
  CONSTRAINT `category_id_refs_id_2d808b40` FOREIGN KEY (`category_id`) REFERENCES `articles_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles_article_categories`
--

LOCK TABLES `articles_article_categories` WRITE;
/*!40000 ALTER TABLE `articles_article_categories` DISABLE KEYS */;
INSERT INTO `articles_article_categories` VALUES (24,3,3),(18,4,3),(25,5,4);
/*!40000 ALTER TABLE `articles_article_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `articles_category`
--

DROP TABLE IF EXISTS `articles_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articles_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `articles_category`
--

LOCK TABLES `articles_category` WRITE;
/*!40000 ALTER TABLE `articles_category` DISABLE KEYS */;
INSERT INTO `articles_category` VALUES (3,'Лінукс','linux'),(4,'Мережі','network'),(5,'Тетсування','tetsuvannya'),(6,'Програмування','programuvannya'),(7,'Інформаційна безпека','informacijna-bezpeka');
/*!40000 ALTER TABLE `articles_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_0e939a4f` (`group_id`),
  KEY `auth_group_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_group_permission_group_id_689710a9a73b7457_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_group__permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_417f1b1c` (`content_type_id`),
  CONSTRAINT `auth__content_type_id_508cf46651277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add menu item',7,'add_menuitem'),(20,'Can change menu item',7,'change_menuitem'),(21,'Can delete menu item',7,'delete_menuitem'),(22,'Can add menu',8,'add_menu'),(23,'Can change menu',8,'change_menu'),(24,'Can delete menu',8,'delete_menu'),(25,'Can add Category',9,'add_category'),(26,'Can change Category',9,'change_category'),(27,'Can delete Category',9,'delete_category'),(28,'Can add Article',11,'add_article'),(29,'Can change Article',11,'change_article'),(30,'Can delete Article',11,'delete_article'),(31,'Can add comment',12,'add_comment'),(32,'Can change comment',12,'change_comment'),(33,'Can delete comment',12,'delete_comment'),(34,'Can moderate comments',12,'can_moderate'),(35,'Can add comment flag',13,'add_commentflag'),(36,'Can change comment flag',13,'change_commentflag'),(37,'Can delete comment flag',13,'delete_commentflag'),(38,'Can add site',14,'add_site'),(39,'Can change site',14,'change_site'),(40,'Can delete site',14,'delete_site');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$12000$2LZ52LWEiJNZ$YJQ9djrkOre9clQa1YqcnqS+qiZMElG+0Fo6gXMeCr4=','2014-12-13 16:00:32',1,'admin','','','gromivchuk.kolya@gmail.com',1,1,'2014-11-19 21:36:46'),(2,'pbkdf2_sha256$10000$qu7o7St1Sxef$MB4bLJwLFk2PrdjQk9GVsxQTPBJ57gU0gkYr8DJ8Sio=','2014-11-21 08:00:11',1,'skara','Oleksandr','Kara','',1,1,'2014-11-20 18:17:23'),(3,'pbkdf2_sha256$10000$knhkxHMt9VYR$ba3aNpT3qRY5C+RzVTdAsed57PziY9O2kB0GZpxJAAo=','2014-11-24 18:47:39',0,'a.boychuk','Andrii','Boychuk','',1,1,'2014-11-24 18:47:39'),(4,'pbkdf2_sha256$10000$ShREahsUYLNJ$R2YZBNOGdhBn57g3nz29awWRU/g/6WLXafHS5qXrfcE=','2014-11-26 21:19:03',0,'roma','Roman','Mintyanskiy','',1,1,'2014-11-26 21:12:09');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_e8701ad4` (`user_id`),
  KEY `auth_user_groups_0e939a4f` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_e8701ad4` (`user_id`),
  KEY `auth_user_user_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_user_user_permissi_user_id_7f0938558328534a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `auth_user_u_permission_id_384b62483d7071f0_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
INSERT INTO `auth_user_user_permissions` VALUES (1,3,25),(2,3,26),(3,3,27),(4,3,28),(5,3,29),(6,3,30),(19,4,25),(20,4,26),(21,4,27),(22,4,28),(23,4,29),(24,4,30);
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_417f1b1c` (`content_type_id`),
  KEY `django_admin_log_e8701ad4` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `djang_content_type_id_697914295151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2014-11-20 18:17:23','2','skara',1,'',4,1),(2,'2014-11-20 18:26:51','2','skara',2,'Changed password, first_name and last_name.',4,1),(3,'2014-11-20 18:27:18','2','skara',2,'Changed password, is_staff and is_superuser.',4,1),(4,'2014-11-20 21:26:08','1','HOME',1,'',8,1),(5,'2014-11-20 22:12:51','1','test',1,'',9,1),(6,'2014-11-20 22:13:04','1','test',1,'',11,1),(7,'2014-11-20 22:14:10','2','test2',1,'',9,1),(8,'2014-11-20 22:14:19','2','test2',1,'',11,1),(9,'2014-11-21 11:39:55','1','HOME',2,'No fields changed.',8,1),(10,'2014-11-21 11:40:30','1','HOME',3,'',8,1),(11,'2014-11-21 12:39:08','2','Testing',1,'',8,1),(12,'2014-11-21 12:39:24','2','HOME',2,'Changed name.',8,1),(13,'2014-11-21 12:39:57','3','Testing',1,'',7,1),(14,'2014-11-21 12:43:15','4','Development Iteration',1,'',7,1),(15,'2014-11-21 12:43:32','4','Development Iteration',2,'No fields changed.',7,1),(16,'2014-11-21 12:44:03','5','Administration',1,'',7,1),(17,'2014-11-21 12:45:38','6','Programming',1,'',7,1),(18,'2014-11-21 12:45:44','2','HOME',2,'No fields changed.',8,1),(19,'2014-11-21 14:54:13','2','Menu',2,'Changed name.',8,1),(20,'2014-11-21 14:54:31','2','Menu',3,'',8,1),(21,'2014-11-21 14:55:00','3','Main',1,'',8,1),(22,'2014-11-21 14:55:33','8','home',1,'',7,1),(23,'2014-11-21 14:56:23','9','artilces',1,'',7,1),(24,'2014-11-21 14:56:57','3','Main',2,'No fields changed.',8,1),(25,'2014-11-24 14:36:04','1','test',3,'',9,1),(26,'2014-11-24 14:36:04','2','test2',3,'',9,1),(27,'2014-11-24 14:36:15','1','test',3,'',11,1),(28,'2014-11-24 14:36:15','2','test2',3,'',11,1),(29,'2014-11-24 15:18:56','3','Linux',1,'',9,1),(30,'2014-11-24 15:39:30','3','sed, a stream editor',1,'',11,1),(31,'2014-11-24 17:11:36','1','itcook.kiev.ua',2,'Changed domain and name.',14,1),(32,'2014-11-24 17:12:18','4','Network',1,'',9,1),(33,'2014-11-24 18:25:46','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(34,'2014-11-24 18:40:53','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(35,'2014-11-24 18:47:39','3','a.boychuk',1,'',4,1),(36,'2014-11-24 18:49:24','3','a.boychuk',2,'Changed password and is_staff.',4,1),(37,'2014-11-24 18:50:08','3','a.boychuk',2,'Changed password, first_name, last_name and user_permissions.',4,1),(38,'2014-11-25 18:40:01','3','Лінукс',2,'Changed title.',9,1),(39,'2014-11-25 18:40:13','4','Мережі',2,'Changed title.',9,1),(40,'2014-11-25 18:40:27','5','Тетсування',1,'',9,1),(41,'2014-11-25 18:40:38','6','Програмування',1,'',9,1),(42,'2014-11-25 18:41:07','7','Інформаційна безпека',1,'',9,1),(43,'2014-11-26 21:12:09','4','roma',1,'',4,1),(44,'2014-11-26 21:12:38','4','roma',2,'Changed password, first_name, last_name, is_staff and user_permissions.',4,1),(45,'2014-11-29 16:30:33','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(46,'2014-11-29 20:33:05','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(47,'2014-11-29 20:36:53','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(48,'2014-11-29 20:40:51','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(49,'2014-11-29 20:42:47','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(50,'2014-11-29 20:46:14','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(51,'2014-11-29 20:49:56','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(52,'2014-11-29 20:54:01','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(53,'2014-11-29 20:56:41','4','roma',2,'Changed password and is_superuser.',4,1),(54,'2014-11-29 20:57:14','4','roma',2,'Changed password and is_superuser.',4,1),(55,'2014-11-29 22:40:06','4','chef-solo',1,'',11,1),(56,'2014-11-29 22:52:49','4','chef-solo',2,'Changed content_markdown.',11,1),(57,'2014-11-29 23:05:28','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(58,'2014-11-29 23:06:16','4','chef-solo',2,'No fields changed.',11,1),(59,'2014-12-02 11:41:46','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(60,'2014-12-02 11:42:35','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(61,'2014-12-02 22:23:25','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(62,'2014-12-03 07:53:17','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(63,'2014-12-03 07:54:25','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(64,'2014-12-03 08:39:52','3','sed, a stream editor',2,'Changed content_markdown.',11,1),(65,'2014-12-13 16:02:54','5','test',1,'',11,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comment_flags`
--

DROP TABLE IF EXISTS `django_comment_flags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comment_flags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `comment_id` int(11) NOT NULL,
  `flag` varchar(30) NOT NULL,
  `flag_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`comment_id`,`flag`),
  KEY `django_comment_flags_6340c63c` (`user_id`),
  KEY `django_comment_flags_3925f323` (`comment_id`),
  KEY `django_comment_flags_9f00eb17` (`flag`),
  CONSTRAINT `comment_id_refs_id_669ff450` FOREIGN KEY (`comment_id`) REFERENCES `django_comments` (`id`),
  CONSTRAINT `user_id_refs_id_73e17509` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comment_flags`
--

LOCK TABLES `django_comment_flags` WRITE;
/*!40000 ALTER TABLE `django_comment_flags` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comment_flags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_comments`
--

DROP TABLE IF EXISTS `django_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content_type_id` int(11) NOT NULL,
  `object_pk` longtext NOT NULL,
  `site_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_name` varchar(50) NOT NULL,
  `user_email` varchar(75) NOT NULL,
  `user_url` varchar(200) NOT NULL,
  `comment` longtext NOT NULL,
  `submit_date` datetime NOT NULL,
  `ip_address` char(15) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `is_removed` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_comments_37ef4eb4` (`content_type_id`),
  KEY `django_comments_99732b5c` (`site_id`),
  KEY `django_comments_6340c63c` (`user_id`),
  CONSTRAINT `content_type_id_refs_id_5ce75e49` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `site_id_refs_id_c6498c81` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`),
  CONSTRAINT `user_id_refs_id_c4f1d065` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_comments`
--

LOCK TABLES `django_comments` WRITE;
/*!40000 ALTER TABLE `django_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_45f3b1d93ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'menu item','treemenus','menuitem'),(8,'menu','treemenus','menu'),(9,'Category','articles','category'),(10,'Article','blog','article'),(11,'Article','articles','article'),(12,'comment','comments','comment'),(13,'comment flag','comments','commentflag'),(14,'site','sites','site');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2014-11-18 13:41:49'),(2,'auth','0001_initial','2014-11-18 13:41:49'),(3,'admin','0001_initial','2014-11-18 13:41:50'),(4,'sessions','0001_initial','2014-11-18 13:41:50');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1ryojhl56h4fk750q4bejhdvy4a1hyhn','NGYxNTI5YWQ0NDY0ZjMzMGZkYTFiMzFkOTUyNGI5ODhkNzczZWM0MzqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHEDVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==','2014-12-04 17:15:49'),('42ne4d91tsqc2kd4wct1ahmfjh5yv6fg','NjU5NWQ5ZDFkOTc0YmNiODNjZjMwOTU1YzVlZTA0NTg4N2RhNjkxZDqAAn1xAVgKAAAAdGVzdGNvb2tpZXECWAYAAAB3b3JrZWRxA3Mu','2015-01-04 12:13:53'),('6msytzfm8df1hg8lpuk38odo1vcqi6ey','NjU5NWQ5ZDFkOTc0YmNiODNjZjMwOTU1YzVlZTA0NTg4N2RhNjkxZDqAAn1xAVgKAAAAdGVzdGNvb2tpZXECWAYAAAB3b3JrZWRxA3Mu','2014-12-04 21:38:07'),('75wuesdbv34bqaotj4wxu0hpa26nwchj','NjU5NWQ5ZDFkOTc0YmNiODNjZjMwOTU1YzVlZTA0NTg4N2RhNjkxZDqAAn1xAVgKAAAAdGVzdGNvb2tpZXECWAYAAAB3b3JrZWRxA3Mu','2014-12-10 21:46:59'),('8r4nl27oxy7tqbghwkilieqec762fixk','NGYxNTI5YWQ0NDY0ZjMzMGZkYTFiMzFkOTUyNGI5ODhkNzczZWM0MzqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHEDVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==','2014-12-05 15:33:13'),('gy33xxwqvrsstf6fxwbotlswsgm8gcp8','NGYxNTI5YWQ0NDY0ZjMzMGZkYTFiMzFkOTUyNGI5ODhkNzczZWM0MzqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHEDVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==','2014-12-04 18:17:00'),('gyaymvrdwkgca0k2cpfhzqy4pn16b4gs','NjU5NWQ5ZDFkOTc0YmNiODNjZjMwOTU1YzVlZTA0NTg4N2RhNjkxZDqAAn1xAVgKAAAAdGVzdGNvb2tpZXECWAYAAAB3b3JrZWRxA3Mu','2014-12-07 18:54:28'),('n0tmjz0qlhi88sl8uret8f8weialgocz','NjU5NWQ5ZDFkOTc0YmNiODNjZjMwOTU1YzVlZTA0NTg4N2RhNjkxZDqAAn1xAVgKAAAAdGVzdGNvb2tpZXECWAYAAAB3b3JrZWRxA3Mu','2014-12-11 19:09:27'),('o25qpf7f6aztr803ug2x467rt0fpcenb','YzdhYjkzYzdlOTU2NTljMzQ0MzI1NjVmZjEwYzY4YThlNmEwODZmNTqAAn1xAS4=','2014-12-27 16:03:09'),('qo8a1aa6emrz5e192tiftf7uw4htom0e','NjU5NWQ5ZDFkOTc0YmNiODNjZjMwOTU1YzVlZTA0NTg4N2RhNjkxZDqAAn1xAVgKAAAAdGVzdGNvb2tpZXECWAYAAAB3b3JrZWRxA3Mu','2014-12-10 11:43:54'),('u0r46kfhj36n982z2ozde3hvz0jmtsn8','NjU5NWQ5ZDFkOTc0YmNiODNjZjMwOTU1YzVlZTA0NTg4N2RhNjkxZDqAAn1xAVgKAAAAdGVzdGNvb2tpZXECWAYAAAB3b3JrZWRxA3Mu','2014-12-09 14:56:03'),('uwm3vjobnj0pdi98rjxd88uuiptm14o3','MTc4OTZjMjY0Y2IxZjY3MzMxZmU1ZDU5NWQ1MjU3NTFlNzc5NzJmYjp7Il9hdXRoX3VzZXJfaGFzaCI6ImEzNmIyMjRlMzllNTY1ZmEwYTBhZGQwOWI4MzNlNTI3MTRlYjMyYWMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOjF9','2014-12-03 21:43:08'),('wa98k1yi684vwuqvrev5gvn99sjkew3i','NDFhMzA2OGYzMDNjOTQyNzgyMTI0NzI0YTRhN2RmNWRmN2Q0MjA3YjqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHEDVQ1fYXV0aF91c2VyX2lkcQSKAQJ1Lg==','2014-12-05 08:00:11'),('z4hvhk8h460bitb0odp0ww74eaovwtkz','ZjFjNjJkYTE4NWNiNWU4YzAxYjFhZmZmMTZlMTQ2ZmZmYWIzN2UwMDqAAn1xAVgKAAAAdGVzdGNvb2tpZVgGAAAAd29ya2VkcQJzLg==','2014-12-09 19:12:33');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'itcook.kiev.ua','itcook.kiev.ua');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treemenus_menu`
--

DROP TABLE IF EXISTS `treemenus_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `treemenus_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `root_item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `treemenus_menu_44644683` (`root_item_id`),
  CONSTRAINT `root_item_id_refs_id_b39d1681` FOREIGN KEY (`root_item_id`) REFERENCES `treemenus_menuitem` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treemenus_menu`
--

LOCK TABLES `treemenus_menu` WRITE;
/*!40000 ALTER TABLE `treemenus_menu` DISABLE KEYS */;
INSERT INTO `treemenus_menu` VALUES (3,'Main',7);
/*!40000 ALTER TABLE `treemenus_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treemenus_menuitem`
--

DROP TABLE IF EXISTS `treemenus_menuitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `treemenus_menuitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `caption` varchar(50) NOT NULL,
  `url` varchar(200) NOT NULL,
  `named_url` varchar(200) NOT NULL,
  `level` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  `menu_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `treemenus_menuitem_410d0aac` (`parent_id`),
  KEY `treemenus_menuitem_08fd5523` (`menu_id`),
  CONSTRAINT `menu_id_refs_id_f53d22d7` FOREIGN KEY (`menu_id`) REFERENCES `treemenus_menu` (`id`),
  CONSTRAINT `parent_id_refs_id_09bf621f` FOREIGN KEY (`parent_id`) REFERENCES `treemenus_menuitem` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treemenus_menuitem`
--

LOCK TABLES `treemenus_menuitem` WRITE;
/*!40000 ALTER TABLE `treemenus_menuitem` DISABLE KEYS */;
INSERT INTO `treemenus_menuitem` VALUES (7,NULL,'root','','',0,0,3),(8,7,'home','/','home',1,0,3),(9,7,'artilces','/articles/','articles',1,1,3);
/*!40000 ALTER TABLE `treemenus_menuitem` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-19 16:00:01
