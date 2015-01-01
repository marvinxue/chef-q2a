# Question2Answer Cookbook

[![Build Status](https://travis-ci.org/sitle/chef-q2a.svg?branch=develop)](https://travis-ci.org/sitle/chef-q2a)

This cookbook install and configure "[Question 2 answer](http://www.question2answer.org/)".

### Requirements

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>["q2a"]["admin"]</tt></td>
    <td>string</td>
    <td>Specify the apps database account.</td>
    <td><tt>q2a</tt></td>
  </tr>
  <tr>
    <td><tt>["q2a"]["password"]</tt></td>
    <td>string</td>
    <td>Specify the apps database password.</td>
    <td><tt>password</tt></td>
  </tr>
  <tr>
    <td><tt>["q2a"]["mysql_root_pw"]</tt></td>
    <td>string</td>
    <td>Specify the root database account.</td>
    <td><tt>password</tt></td>
  </tr>
  <tr>
    <td><tt>["q2a"]["database_server"]</tt></td>
    <td>string</td>
    <td>Specify the database host.</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>["q2a"]["apps"]</tt></td>
    <td>string</td>
    <td>Specify the apps name.</td>
    <td><tt>q2a</tt></td>
  </tr>
  <tr>
    <td><tt>["q2a"]["repository"]</tt></td>
    <td>string</td>
    <td>Specify the projetct GIT repository.</td>
    <td><tt>https://github.com/q2a/question2answer.git</tt></td>
  </tr>
  <tr>
    <td><tt>["q2a"]["domain"]</tt></td>
    <td>string</td>
    <td>Specify the virtualhost domain name.</td>
    <td><tt>www.apps.com</tt></td>
  </tr>
  <tr>
    <td><tt>["q2a"]["apps_server"]</tt></td>
    <td>string</td>
    <td>Specify the apps server IP address*.</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>["q2a"]["plugins"]["language"]</tt></td>
    <td>string</td>
    <td>Specify the link to download an additionnal language pack.</td>
    <td><tt>http://www.question2answer.org/third-party/question2answer-1.6-language-fr.zip</tt></td>
  </tr>
</table>

\* used to restrict the access to the database server.
 
## Usage

Actually, this cookbook is composed by 2 recipes :

* database.rb
* apps.rb

The default recipe is not used here.

### Database role (install the database)

You need to create a database role like this :

```
{
  "name": "q2a-db",
  "description": "Q2A Database role.",
  "json_class": "Chef::Role",
  "default_attributes": {
  },
  "override_attributes": {
  },
  "chef_type": "role",
  "run_list": [
    "recipe[q2a::database]"
  ],
  "env_run_lists": {
  }
}
```
This role have to be applied to your database node so it can install and configure the database server for q2a.

### Apps role (install the q2a apps)

You need to create an apps role like this :

```
{
  "name": "q2a-apps",
  "description": "Q2A Apps role.",
  "json_class": "Chef::Role",
  "default_attributes": {
  },
  "override_attributes": {
  },
  "chef_type": "role",
  "run_list": [
    "recipe[q2a::apps]"
  ],
  "env_run_lists": {
  }
}
```
This role have to be applied to your webserver node so it can install and configure the apps server for q2a.

### All in one role (install the q2a database and q2a app on the same server)

You can, of course, install all component in one server. Create the role like this :

```
{
  "name": "q2a-instance",
  "description": "Q2A All In One server.",
  "json_class": "Chef::Role",
  "default_attributes": {
  },
  "override_attributes": {
  },
  "chef_type": "role",
  "run_list": [
    "recipe[q2a::database]",
    "recipe[q2a::apps]"
  ],
  "env_run_lists": {
  }
}
```
Apply this role to your server and you are done.


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

### License 

```
Copyright 2014 Léonard TAVAE

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

### Authors 

* Léonard TAVAE