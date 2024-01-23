### Домашнее задание к занятию 9.3 «Процессы CI/CD» Баранов Сергей

### Подготовка к выполнению

1. Создайте два VM в Yandex Cloud с параметрами: 2CPU 4RAM Centos7 (остальное по минимальным требованиям).

2. Пропишите в [inventory](./infrastructure/inventory/cicd/hosts.yml) [playbook](./infrastructure/site.yml) созданные хосты.

[hosts.yml](https://github.com/12sergey12/9.3_CI-CD-processes/blob/main/infrastructure/inventory/cicd/hosts.yml)

```
---
all:
  hosts:
    sonar-01:
      ansible_host: 178.154.200.93
    nexus-01:
      ansible_host: 178.154.205.189
  children:
    sonarqube:
      hosts:
        sonar-01:
    nexus:
      hosts:
        nexus-01:
    postgres:
      hosts:
        sonar-01:
  vars:
    ansible_connection_type: parcamiko
    ansible_user: centos
```

3. Добавьте в [files](./infrastructure/files/) файл со своим публичным ключом (id_rsa.pub). Если ключ называется иначе — найдите таску в плейбуке, которая использует id_rsa.pub имя, и исправьте на своё.

4. Запустите playbook, ожидайте успешного завершения.

<details><summary>ansible-playbook</summary>

```
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/infrastructure# ansible-playbook -i ./inventory/cicd/hosts.yml site.yml

PLAY [Get OpenJDK installed] *****************************************************************************

TASK [Gathering Facts] ***********************************************************************************
ok: [sonar-01]

TASK [install unzip] *************************************************************************************
changed: [sonar-01]

TASK [Upload .tar.gz file conaining binaries from remote storage] ****************************************
changed: [sonar-01]

TASK [Ensure installation dir exists] ********************************************************************
changed: [sonar-01]

TASK [Extract java in the installation directory] ********************************************************
changed: [sonar-01]

TASK [Export environment variables] **********************************************************************
changed: [sonar-01]

PLAY [Get PostgreSQL installed] **************************************************************************

TASK [Gathering Facts] ***********************************************************************************
ok: [sonar-01]

TASK [Change repo file] **********************************************************************************
changed: [sonar-01]

TASK [Install PostgreSQL repos] **************************************************************************
changed: [sonar-01]

TASK [Install PostgreSQL] ********************************************************************************
changed: [sonar-01]

TASK [Init template1 DB] *********************************************************************************
changed: [sonar-01]

TASK [Start pgsql service] *******************************************************************************
changed: [sonar-01]

TASK [Create user in system] *****************************************************************************
changed: [sonar-01]

TASK [Create user for Sonar in PostgreSQL] ***************************************************************
[WARNING]: Module remote_tmp /var/lib/pgsql/.ansible/tmp did not exist and was created with a mode of
0700, this may cause issues when running as another user. To avoid this, create the remote_tmp dir with
the correct permissions manually
changed: [sonar-01]

TASK [Change password for Sonar user in PostgreSQL] ******************************************************
changed: [sonar-01]

TASK [Create Sonar DB] ***********************************************************************************
changed: [sonar-01]

TASK [Copy pg_hba.conf] **********************************************************************************
changed: [sonar-01]

PLAY [Prepare Sonar host] ********************************************************************************

TASK [Gathering Facts] ***********************************************************************************
ok: [sonar-01]

TASK [Create group in system] ****************************************************************************
ok: [sonar-01]

TASK [Create user in system] *****************************************************************************
ok: [sonar-01]

TASK [Set up ssh key to access for managed node] *********************************************************
changed: [sonar-01]

TASK [Allow group to have passwordless sudo] *************************************************************
changed: [sonar-01]

TASK [Increase Virtual Memory] ***************************************************************************
changed: [sonar-01]

TASK [Reboot VM] *****************************************************************************************
changed: [sonar-01]

PLAY [Get Sonarqube installed] ***************************************************************************

TASK [Gathering Facts] ***********************************************************************************
ok: [sonar-01]

TASK [Get distrib ZIP] ***********************************************************************************
changed: [sonar-01]

TASK [Unzip Sonar] ***************************************************************************************
changed: [sonar-01]

TASK [Move Sonar into place.] ****************************************************************************
changed: [sonar-01]

TASK [Configure SonarQube JDBC settings for PostgreSQL.] *************************************************
changed: [sonar-01] => (item={'regexp': '^sonar.jdbc.username', 'line': 'sonar.jdbc.username=sonar'})
changed: [sonar-01] => (item={'regexp': '^sonar.jdbc.password', 'line': 'sonar.jdbc.password=sonar'})
changed: [sonar-01] => (item={'regexp': '^sonar.jdbc.url', 'line': 'sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance'})
changed: [sonar-01] => (item={'regexp': '^sonar.web.context', 'line': 'sonar.web.context='})

TASK [Generate wrapper.conf] *****************************************************************************
changed: [sonar-01]

TASK [Symlink sonar bin.] ********************************************************************************
changed: [sonar-01]

TASK [Copy SonarQube systemd unit file into place (for systemd systems).] ********************************
changed: [sonar-01]

TASK [Ensure Sonar is running and set to start on boot.] *************************************************
changed: [sonar-01]

TASK [Allow Sonar time to build on first start.] *********************************************************
Pausing for 180 seconds
(ctrl+C then 'C' = continue early, ctrl+C then 'A' = abort)
ok: [sonar-01]

TASK [Make sure Sonar is responding on the configured port.] *********************************************
ok: [sonar-01]

PLAY [Get Nexus installed] *******************************************************************************

TASK [Gathering Facts] ***********************************************************************************
ok: [nexus-01]

TASK [Create Nexus group] ********************************************************************************
changed: [nexus-01]

TASK [Create Nexus user] *********************************************************************************
changed: [nexus-01]

TASK [Install JDK] ***************************************************************************************
changed: [nexus-01]

TASK [Create Nexus directories] **************************************************************************
changed: [nexus-01] => (item=/home/nexus/log)
changed: [nexus-01] => (item=/home/nexus/sonatype-work/nexus3)
changed: [nexus-01] => (item=/home/nexus/sonatype-work/nexus3/etc)
changed: [nexus-01] => (item=/home/nexus/pkg)
changed: [nexus-01] => (item=/home/nexus/tmp)

TASK [Download Nexus] ************************************************************************************
[WARNING]: Module remote_tmp /home/nexus/.ansible/tmp did not exist and was created with a mode of 0700,
this may cause issues when running as another user. To avoid this, create the remote_tmp dir with the
correct permissions manually
changed: [nexus-01]

TASK [Unpack Nexus] **************************************************************************************
changed: [nexus-01]

TASK [Link to Nexus Directory] ***************************************************************************
changed: [nexus-01]

TASK [Add NEXUS_HOME for Nexus user] *********************************************************************
changed: [nexus-01]

TASK [Add run_as_user to Nexus.rc] ***********************************************************************
changed: [nexus-01]

TASK [Raise nofile limit for Nexus user] *****************************************************************
changed: [nexus-01]

TASK [Create Nexus service for SystemD] ******************************************************************
changed: [nexus-01]

TASK [Ensure Nexus service is enabled for SystemD] *******************************************************
changed: [nexus-01]

TASK [Create Nexus vmoptions] ****************************************************************************
changed: [nexus-01]

TASK [Create Nexus properties] ***************************************************************************
changed: [nexus-01]

TASK [Lower Nexus disk space threshold] ******************************************************************
skipping: [nexus-01]

TASK [Start Nexus service if enabled] ********************************************************************
changed: [nexus-01]

TASK [Ensure Nexus service is restarted] *****************************************************************
skipping: [nexus-01]

TASK [Wait for Nexus port if started] ********************************************************************
ok: [nexus-01]

PLAY RECAP ***********************************************************************************************
nexus-01                   : ok=17   changed=15   unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
sonar-01                   : ok=35   changed=27   unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/infrastructure#

```

</details>


5. Проверьте готовность SonarQube через [браузер](http://localhost:9000).

6. Зайдите под admin\admin, поменяйте пароль на свой.

7.  Проверьте готовность Nexus через [бразуер](http://localhost:8081).

8. Подключитесь под admin\admin123, поменяйте пароль, сохраните анонимный доступ.

## Знакомоство с SonarQube

### Основная часть

1. Создайте новый проект, название произвольное.

2. Скачайте пакет sonar-scanner, который вам предлагает скачать SonarQube.

3. Сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).

```
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example/sonar-scanner-5.0.1.3006-linux/bin# export PATH=$(pwd):$PATH
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example#
```

4. Проверьте `sonar-scanner --version`.

```
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example# sonar-scanner --version
INFO: Scanner configuration file: /home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example/sonar-scanner-5.0.1.3006-linux/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: SonarScanner 5.0.1.3006
INFO: Java 17.0.7 Eclipse Adoptium (64-bit)
INFO: Linux 5.10.0-27-amd64 amd64
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example# 
```

5. Запустите анализатор против кода из директории [example](./example) с дополнительным ключом `-Dsonar.coverage.exclusions=fail.py`.

<details><summary>sonar-scanner</summary>

```
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example# sonar-scanner \
  -Dsonar.projectKey=netology \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://178.154.200.93:9000 \
  -Dsonar.login=24dcd473ea58e71933b60b33a5b633331d5460b7 \
> -Dsonar.coverage.exclusions=fail.py
INFO: Scanner configuration file: /home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example/sonar-scanner-5.0.1.3006-linux/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: SonarScanner 5.0.1.3006
INFO: Java 17.0.7 Eclipse Adoptium (64-bit)
INFO: Linux 5.10.0-27-amd64 amd64
INFO: User cache: /root/.sonar/cache
INFO: Analyzing on SonarQube server 9.1.0
INFO: Default locale: "ru_RU", source code encoding: "UTF-8" (analysis is platform dependent)
INFO: Load global settings
INFO: Load global settings (done) | time=438ms
INFO: Server id: 9CFC3560-AY02a-eaUNv80wAwcHKO
INFO: User cache: /root/.sonar/cache
INFO: Load/download plugins
INFO: Load plugins index
INFO: Load plugins index (done) | time=259ms
INFO: Load/download plugins (done) | time=1355ms
INFO: Process project properties
INFO: Process project properties (done) | time=12ms
INFO: Execute project builders
INFO: Execute project builders (done) | time=3ms
INFO: Project key: netology
INFO: Base dir: /home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example
INFO: Working dir: /home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example/.scannerwork
INFO: Load project settings for component key: 'netology'
INFO: Load project settings for component key: 'netology' (done) | time=117ms
INFO: Load quality profiles
INFO: Load quality profiles (done) | time=386ms
INFO: Load active rules
INFO: Load active rules (done) | time=4996ms
INFO: Indexing files...
INFO: Project configuration:
INFO:   Excluded sources for coverage: fail.py
INFO: 253 files indexed
INFO: 0 files ignored because of scm ignore settings
INFO: Quality profile for py: Sonar way
INFO: ------------- Run sensors on module netology
INFO: Load metrics repository
INFO: Load metrics repository (done) | time=175ms
INFO: Sensor Python Sensor [python]
WARN: Your code is analyzed as compatible with python 2 and 3 by default. This will prevent the detection of issues specific to python 2 or python 3. You can get a more precise analysis by setting a python version in your configuration via the parameter "sonar.python.version"
INFO: Starting global symbols computation
INFO: 1 source file to be analyzed
INFO: Load project repositories
INFO: Load project repositories (done) | time=129ms
INFO: 1/1 source file has been analyzed
INFO: Starting rules execution
INFO: 1 source file to be analyzed
INFO: 1/1 source file has been analyzed
INFO: Sensor Python Sensor [python] (done) | time=1913ms
INFO: Sensor Cobertura Sensor for Python coverage [python]
INFO: Sensor Cobertura Sensor for Python coverage [python] (done) | time=18ms
INFO: Sensor PythonXUnitSensor [python]
INFO: Sensor PythonXUnitSensor [python] (done) | time=15ms
INFO: Sensor CSS Rules [cssfamily]
INFO: No CSS, PHP, HTML or VueJS files are found in the project. CSS analysis is skipped.
INFO: Sensor CSS Rules [cssfamily] (done) | time=12ms
INFO: Sensor JaCoCo XML Report Importer [jacoco]
INFO: 'sonar.coverage.jacoco.xmlReportPaths' is not defined. Using default locations: target/site/jacoco/jacoco.xml,target/site/jacoco-it/jacoco.xml,build/reports/jacoco/test/jacocoTestReport.xml
INFO: No report imported, no coverage information will be imported by JaCoCo XML Report Importer
INFO: Sensor JaCoCo XML Report Importer [jacoco] (done) | time=14ms
INFO: Sensor C# Project Type Information [csharp]
INFO: Sensor C# Project Type Information [csharp] (done) | time=1ms
INFO: Sensor C# Analysis Log [csharp]
INFO: Sensor C# Analysis Log [csharp] (done) | time=68ms
INFO: Sensor C# Properties [csharp]
INFO: Sensor C# Properties [csharp] (done) | time=1ms
INFO: Sensor JavaXmlSensor [java]
INFO: Sensor JavaXmlSensor [java] (done) | time=8ms
INFO: Sensor HTML [web]
INFO: Sensor HTML [web] (done) | time=7ms
INFO: Sensor VB.NET Project Type Information [vbnet]
INFO: Sensor VB.NET Project Type Information [vbnet] (done) | time=3ms
INFO: Sensor VB.NET Analysis Log [vbnet]
INFO: Sensor VB.NET Analysis Log [vbnet] (done) | time=121ms
INFO: Sensor VB.NET Properties [vbnet]
INFO: Sensor VB.NET Properties [vbnet] (done) | time=0ms
INFO: ------------- Run sensors on project
INFO: Sensor Zero Coverage Sensor
INFO: Sensor Zero Coverage Sensor (done) | time=9ms
INFO: SCM Publisher SCM provider for this project is: git
INFO: SCM Publisher 1 source file to be analyzed
INFO: SCM Publisher 0/1 source files have been analyzed (done) | time=538ms
WARN: Missing blame information for the following files:
WARN:   * fail.py
WARN: This may lead to missing/broken features in SonarQube
INFO: CPD Executor Calculating CPD for 1 file
INFO: CPD Executor CPD calculation finished (done) | time=71ms
INFO: Analysis report generated in 223ms, dir size=103,2 kB
INFO: Analysis report compressed in 105ms, zip size=14,3 kB
INFO: Analysis report uploaded in 183ms
INFO: ANALYSIS SUCCESSFUL, you can browse http://178.154.200.93:9000/dashboard?id=netology
INFO: Note that you will be able to access the updated dashboard once the server has processed the submitted analysis report
INFO: More about the report processing at http://178.154.200.93:9000/api/ce/task?id=AY022dpJUNv80wAwcMPV
INFO: Analysis total time: 16.987 s
INFO: ------------------------------------------------------------------------
INFO: EXECUTION SUCCESS
INFO: ------------------------------------------------------------------------
INFO: Total time: 24.484s
INFO: Final Memory: 8M/37M
INFO: ------------------------------------------------------------------------
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example# 

```

</details>


6. Посмотрите результат в интерфейсе.

![monitoring](https://github.com/12sergey12/9.3_CI-CD-processes/blob/main/images/9.3-1_SONAR-SCANER-1.png)

7. Исправьте ошибки, которые он выявил, включая warnings.

8. Запустите анализатор повторно — проверьте, что QG пройдены успешно.

<details><summary>sonar-scanner(повторно)</summary>

```
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example# sonar-scanner   -Dsonar.projectKey=netology   -Dsonar.sources=.   -Dsonar.host.url=http://178.154.200.93:9000   -Dsonar.login=24dcd473ea58e71933b60b33a5b633331d5460b7 -Dsonar.coverage.exclusions=fail.py
INFO: Scanner configuration file: /home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example/sonar-scanner-5.0.1.3006-linux/conf/sonar-scanner.properties
INFO: Project root configuration file: NONE
INFO: SonarScanner 5.0.1.3006
INFO: Java 17.0.7 Eclipse Adoptium (64-bit)
INFO: Linux 5.10.0-27-amd64 amd64
INFO: User cache: /root/.sonar/cache
INFO: Analyzing on SonarQube server 9.1.0
INFO: Default locale: "ru_RU", source code encoding: "UTF-8" (analysis is platform dependent)
INFO: Load global settings
INFO: Load global settings (done) | time=747ms
INFO: Server id: 9CFC3560-AY02a-eaUNv80wAwcHKO
INFO: User cache: /root/.sonar/cache
INFO: Load/download plugins
INFO: Load plugins index
INFO: Load plugins index (done) | time=275ms
INFO: Load/download plugins (done) | time=407ms
INFO: Process project properties
INFO: Process project properties (done) | time=18ms
INFO: Execute project builders
INFO: Execute project builders (done) | time=3ms
INFO: Project key: netology
INFO: Base dir: /home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example
INFO: Working dir: /home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example/.scannerwork
INFO: Load project settings for component key: 'netology'
INFO: Load project settings for component key: 'netology' (done) | time=2043ms
INFO: Load quality profiles
INFO: Load quality profiles (done) | time=1680ms
INFO: Load active rules
INFO: Load active rules (done) | time=35097ms
INFO: Indexing files...
INFO: Project configuration:
INFO:   Excluded sources for coverage: fail.py
INFO: 253 files indexed
INFO: 0 files ignored because of scm ignore settings
INFO: Quality profile for py: Sonar way
INFO: ------------- Run sensors on module netology
INFO: Load metrics repository
INFO: Load metrics repository (done) | time=890ms
INFO: Sensor Python Sensor [python]
WARN: Your code is analyzed as compatible with python 2 and 3 by default. This will prevent the detection of issues specific to python 2 or python 3. You can get a more precise analysis by setting a python version in your configuration via the parameter "sonar.python.version"
INFO: Starting global symbols computation
INFO: 1 source file to be analyzed
INFO: Load project repositories
INFO: Load project repositories (done) | time=702ms
INFO: 1/1 source file has been analyzed
INFO: Starting rules execution
INFO: 1 source file to be analyzed
INFO: 1/1 source file has been analyzed
INFO: Sensor Python Sensor [python] (done) | time=1928ms
INFO: Sensor Cobertura Sensor for Python coverage [python]
INFO: Sensor Cobertura Sensor for Python coverage [python] (done) | time=44ms
INFO: Sensor PythonXUnitSensor [python]
INFO: Sensor PythonXUnitSensor [python] (done) | time=11ms
INFO: Sensor CSS Rules [cssfamily]
INFO: No CSS, PHP, HTML or VueJS files are found in the project. CSS analysis is skipped.
INFO: Sensor CSS Rules [cssfamily] (done) | time=6ms
INFO: Sensor JaCoCo XML Report Importer [jacoco]
INFO: 'sonar.coverage.jacoco.xmlReportPaths' is not defined. Using default locations: target/site/jacoco/jacoco.xml,target/site/jacoco-it/jacoco.xml,build/reports/jacoco/test/jacocoTestReport.xml
INFO: No report imported, no coverage information will be imported by JaCoCo XML Report Importer
INFO: Sensor JaCoCo XML Report Importer [jacoco] (done) | time=27ms
INFO: Sensor C# Project Type Information [csharp]
INFO: Sensor C# Project Type Information [csharp] (done) | time=3ms
INFO: Sensor C# Analysis Log [csharp]
INFO: Sensor C# Analysis Log [csharp] (done) | time=36ms
INFO: Sensor C# Properties [csharp]
INFO: Sensor C# Properties [csharp] (done) | time=2ms
INFO: Sensor JavaXmlSensor [java]
INFO: Sensor JavaXmlSensor [java] (done) | time=23ms
INFO: Sensor HTML [web]
INFO: Sensor HTML [web] (done) | time=12ms
INFO: Sensor VB.NET Project Type Information [vbnet]
INFO: Sensor VB.NET Project Type Information [vbnet] (done) | time=1ms
INFO: Sensor VB.NET Analysis Log [vbnet]
INFO: Sensor VB.NET Analysis Log [vbnet] (done) | time=35ms
INFO: Sensor VB.NET Properties [vbnet]
INFO: Sensor VB.NET Properties [vbnet] (done) | time=0ms
INFO: ------------- Run sensors on project
INFO: Sensor Zero Coverage Sensor
INFO: Sensor Zero Coverage Sensor (done) | time=9ms
INFO: SCM Publisher SCM provider for this project is: git
INFO: SCM Publisher 1 source file to be analyzed
INFO: SCM Publisher 0/1 source files have been analyzed (done) | time=313ms
WARN: Missing blame information for the following files:
WARN:   * fail.py
WARN: This may lead to missing/broken features in SonarQube
INFO: CPD Executor Calculating CPD for 1 file
INFO: CPD Executor CPD calculation finished (done) | time=38ms
INFO: Analysis report generated in 179ms, dir size=103,0 kB
INFO: Analysis report compressed in 96ms, zip size=14,0 kB
INFO: Analysis report uploaded in 3919ms
INFO: ANALYSIS SUCCESSFUL, you can browse http://178.154.200.93:9000/dashboard?id=netology
INFO: Note that you will be able to access the updated dashboard once the server has processed the submitted analysis report
INFO: More about the report processing at http://178.154.200.93:9000/api/ce/task?id=AY024s96UNv80wAwcMPW
INFO: Analysis total time: 50.246 s
INFO: ------------------------------------------------------------------------
INFO: EXECUTION SUCCESS
INFO: ------------------------------------------------------------------------
INFO: Total time: 54.229s
INFO: Final Memory: 8M/34M
INFO: ------------------------------------------------------------------------
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/example#

```

</details>


9. Сделайте скриншот успешного прохождения анализа, приложите к решению ДЗ.

![monitoring](https://github.com/12sergey12/9.3_CI-CD-processes/blob/main/images/9.3-1_SONAR-SCANER-2.png)



### Знакомство с Nexus

### Основная часть


1. В репозиторий `maven-public` загрузите артефакт с GAV-параметрами:

 *    groupId: netology;
 *    artifactId: java;
 *    version: 8_282;
 *    classifier: distrib;
 *    type: tar.gz.
   
2. В него же загрузите такой же артефакт, но с version: 8_102.

![monitoring](https://github.com/12sergey12/9.3_CI-CD-processes/blob/main/images/9.3_MAVEN-PUBLIC.png)

3. Проверьте, что все файлы загрузились успешно.

4. В ответе пришлите файл `maven-metadata.xml` для этого артефекта.

[maven-metadata.xml](https://github.com/12sergey12/9.3_CI-CD-processes/blob/main/maven-metadata.xml)

```
<metadata modelVersion="1.1.0">
<groupId>netology</groupId>
<artifactId>java</artifactId>
<versioning>
<latest>8_282</latest>
<release>8_282</release>
<versions>
<version>8_102</version>
<version>8_282</version>
</versions>
<lastUpdated>20240123133533</lastUpdated>
</versioning>
</metadata>
```

![monitoring](https://github.com/12sergey12/9.3_CI-CD-processes/blob/main/images/9.3_MAVEN-PUBLIC_HTML.png)



### Знакомство с Maven


### Подготовка к выполнению


1. Скачайте дистрибутив с [maven](https://maven.apache.org/download.cgi).

```
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/mvn# wget -q https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz && 
sudo mkdir -p /opt/jdk && 
sudo tar -zxf openjdk-11+28_linux-x64_bin.tar.gz -C /opt/jdk/ && 
/opt/jdk/jdk-11/bin/java -version

openjdk version "11" 2018-09-25
OpenJDK Runtime Environment 18.9 (build 11+28)
OpenJDK 64-Bit Server VM 18.9 (build 11+28, mixed mode)
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/mvn# 
```

```
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/mvn# wget -q https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip && 
sudo unzip -q -d /opt apache-maven-3.9.6-bin.zip && 
export PATH=$PATH:/opt/apache-maven-3.9.6/bin && 
export JAVA_HOME=/opt/jdk/jdk-11 && mvn --version

Apache Maven 3.9.6 (bc0240f3c744dd6b6ec2920b3cd08dcc295161ae)
Maven home: /opt/apache-maven-3.9.6
Java version: 11, vendor: Oracle Corporation, runtime: /opt/jdk/jdk-11
Default locale: ru_RU, platform encoding: UTF-8
OS name: "linux", version: "5.10.0-27-amd64", arch: "amd64", family: "unix"
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/mvn#
```


2. Разархивируйте, сделайте так, чтобы binary был доступен через вызов в shell (или поменяйте переменную PATH, или любой другой, удобный вам способ).

3. Удалите из `apache-maven-<version>/conf/settings.xml` упоминание о правиле, отвергающем HTTP- соединение — раздел mirrors —> id: my-repository-http-unblocker.

Удаляем из apache-maven-<version>/conf/settings.xml упоминание о правиле, отвергающем http соединение( раздел mirrors->id: my-repository-http-blocker): закомментирован блок

```
<!--<mirror>
   <id>maven-default-http-blocker</id>
   <mirrorOf>external:http:*</mirrorOf>
   <name>Pseudo repository to mirror external repositories initially using HTTP.</name>
   <url>http://0.0.0.0/</url>
   <blocked>true</blocked>
 </mirror> -->
```

4. Проверьте `mvn --version`.

5. Заберите директорию [mvn](./mvn) с pom.


### Основная часть


1. Поменяйте в `pom.xml` блок с зависимостями под ваш артефакт из первого пункта задания для Nexus (java с версией 8_282).

[pom.xml](https://github.com/12sergey12/9.3_CI-CD-processes/blob/main/mvn/pom.xml)

```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
 
  <groupId>com.netology.app</groupId>
  <artifactId>simple-app</artifactId>
  <version>1.0-SNAPSHOT</version>
   <repositories>
    <repository>
      <id>my-repo</id>
      <name>maven-public</name>
      <url>http://178.154.205.189:8081/repository/maven-public/</url>
    </repository>
  </repositories>
  <dependencies>
     <dependency>
      <groupId>netology</groupId>
      <artifactId>java</artifactId>
      <version>8_282</version>
      <classifier>distrib</classifier>
      <type>tar.gz</type>
    </dependency>
  </dependencies>
</project>
```

2. Запустите команду `mvn package` в директории с `pom.xml`, ожидайте успешного окончания.

<details><summary>Вывод команды mvn package</summary>

```
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/mvn# mvn package
[INFO] Scanning for projects...
[INFO] 
[INFO] --------------------< com.netology.app:simple-app >---------------------
[INFO] Building simple-app 1.0-SNAPSHOT
[INFO]   from pom.xml
[INFO] --------------------------------[ jar ]---------------------------------
Downloading from my-repo: http://178.154.205.189:8081/repository/maven-public/netology/java/8_282/java-8_282.pom
[WARNING] The POM for netology:java:tar.gz:distrib:8_282 is missing, no dependency information available
Downloading from my-repo: http://178.154.205.189:8081/repository/maven-public/netology/java/8_282/java-8_282-distrib.tar.gz
Downloaded from my-repo: http://178.154.205.189:8081/repository/maven-public/netology/java/8_282/java-8_282-distrib.tar.gz (248 B at 1.4 kB/s)
[INFO] 
[INFO] --- resources:3.3.1:resources (default-resources) @ simple-app ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory /home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/mvn/src/main/resources
[INFO] 
[INFO] --- compiler:3.11.0:compile (default-compile) @ simple-app ---
[INFO] No sources to compile
[INFO] 
[INFO] --- resources:3.3.1:testResources (default-testResources) @ simple-app ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] skip non existing resourceDirectory /home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/mvn/src/test/resources
[INFO] 
[INFO] --- compiler:3.11.0:testCompile (default-testCompile) @ simple-app ---
[INFO] No sources to compile
[INFO] 
[INFO] --- surefire:3.2.2:test (default-test) @ simple-app ---
[INFO] No tests to run.
[INFO] 
[INFO] --- jar:3.3.0:jar (default-jar) @ simple-app ---
[WARNING] JAR will be empty - no content was marked for inclusion!
[INFO] Building jar: /home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/mvn/target/simple-app-1.0-SNAPSHOT.jar
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  3.830 s
[INFO] Finished at: 2024-01-23T21:28:03+07:00
[INFO] ------------------------------------------------------------------------
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/mvn# 

```

</details>

3. Проверьте директорию `~/.m2/repository/`, найдите ваш артефакт.

```
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/mvn# ls ~/.m2/repository/netology/java/8_282/
java-8_282-distrib.tar.gz	
java-8_282.pom.lastUpdated
java-8_282-distrib.tar.gz.sha1	
_remote.repositories
root@baranovsa:/home/baranovsa/9.3_baranov/mnt-homeworks/09-ci-03-cicd/mvn# 
```
4. В ответе пришлите исправленный файл `pom.xml`.

```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
 
  <groupId>com.netology.app</groupId>
  <artifactId>simple-app</artifactId>
  <version>1.0-SNAPSHOT</version>
   <repositories>
    <repository>
      <id>my-repo</id>
      <name>maven-public</name>
      <url>http://178.154.205.189:8081/repository/maven-public/</url>
    </repository>
  </repositories>
  <dependencies>
     <dependency>
      <groupId>netology</groupId>
      <artifactId>java</artifactId>
      <version>8_282</version>
      <classifier>distrib</classifier>
      <type>tar.gz</type>
    </dependency>
  </dependencies>
</project>
```


---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
