# fluent-plugin-elasticsearch-stats

[Fluentd](https://fluentd.org/) input plugin to fetch stats on elasticsearch.

It uses the elasticsearch following endpoints:

- **Cluster Heath** through **/_cluster/health?level=indices**
- **Cluster Stats** through **/_cluster/stats**
- **Node Stats** through **/_nodes/stats** or **/_nodes/_local/stats**
- **Indices Stats** through **/_all/_stats**
- **Shard Stats** through **/_all/_stats?level=shards**
- **Dangling** through **/_dangling**


## plugins

### in - elasticsearch-stats

Fetch stats with elasticsearch, and convert stats to metrics.

#### global options

| setting    | type        | default                           | description                       |
|------------|-------------|-----------------------------------|-----------------------------------|
| urls       |             | ["http://localhost:9200"]         | list of servers to poll           |
| timeout    | second      | 10                                | timeout for each call             |
| username   |             |                                   | username for basic authentication |
| password   |             |                                   | password for basic authentication |
| interval   | second      | 300                               | interval for stat probe execution |
| user_agent |             | fluent-plugin-elasticsearch-stats | user agent for http request       |
| ca_file    | file        |                                   | CA cert file to use for request   |
| verify_ssl | true\|false | true                              | option to verify certificate/host |

#### cluster health options

Events from **/_cluster/health?level=indices**.

| setting              | type             | default | description                          |
|----------------------|------------------|---------|--------------------------------------|
| cluster_health       | true\|false      | false   | enable cluster health events collect |
| cluster_health_level | indices\|cluster | indices |                                      |

#### cluster starts options

Events from **/_cluster/stats**.

| setting                        | type        | default | description                                |
|--------------------------------|-------------|---------|--------------------------------------------|
| cluster_stats                  | true\|false | false   | enable cluster stats events collect        |
| cluster_stats_only_from_master | true\|false | true    | gather cluster stats from master node only |

#### node stats options

Events from **/_nodes/stats**.

| setting          | type                                                                 | default | description                                                                                  |
|------------------|----------------------------------------------------------------------|---------|----------------------------------------------------------------------------------------------|
| node_stats       | true\|false                                                          | true    | enable node stats events collect                                                             |
| node_stats_local | true\|false                                                          | false   | when **true**, fetch only current node stats, when **false**, fetch all cluster nodes stats. |
| node_stats_subs  | indices, os, process, jvm, thread_pool, fs, transport, http, breaker | []      |                                                                                              |

#### indices stats options

Events from **/_all/_stats**.

| setting                         | type                     | default  | description                         |
|---------------------------------|--------------------------|----------|-------------------------------------|
| indices_stats                   | true\|false              | true     | enable indices stats events collect |
| indices_stats_level             | shards\|indices\|cluster | shards   |                                     |
| indices_stats_include           |                          | ["_all"] | indices to collect stats on         |
| indices_stats_aggregate_pattern |                          |          | regexp to aggregate indices stats   |

#### shards stats options

Events from **/_all/_stats?level=shards**.

| setting      | type        | default | description                        |
|--------------|-------------|---------|------------------------------------|
| shards_stats | true\|false | false   | enable shards stats events collect |

#### dangling options

Events from **/_dangling**.

| setting  | type        | default | description                    |
|----------|-------------|---------|--------------------------------|
| dangling | true\|false | false   | enable dangling events collect |


## Installation

Manual install, by executing:

    $ gem install fluent-plugin-elasticsearch-stats

Add to Gemfile with:

    $ bundle add fluent-plugin-elasticsearch-stats


## Copyright

* Copyright(c) 2024- Thomas Tych
* License
  * Apache License, Version 2.0
