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

Example of config

``` text
<source>
  @type elasticsearch_stats

  tag elastic.metrics

  cluster_health true
  cluster_stats false
  nodes_stats false
</source>
```

#### global options

| setting                       | type               | default                           | description                                                         |
|-------------------------------|--------------------|-----------------------------------|---------------------------------------------------------------------|
| tag                           |                    | elasticsearch_stats               | tag to emit events on                                               |
| urls                          |                    | ["http://localhost:9200"]         | list of urls to poll                                                |
| timeout                       | second             | 10                                | timeout for each call                                               |
| username                      |                    |                                   | username for basic authentication                                   |
| password                      |                    |                                   | password for basic authentication                                   |
| user_agent                    |                    | fluent-plugin-elasticsearch-stats | user agent for http request                                         |
| ca_file                       | file               |                                   | CA cert file to use for request                                     |
| verify_ssl                    | bool               | true                              | option to verify certificate/host                                   |
|                               |                    |                                   |                                                                     |
| interval                      | second             | 300                               | interval for probe execution                                        |
|                               |                    |                                   |                                                                     |
| metric_prefix                 |                    |                                   | prefix for metric fields                                            |
| metadata_prefix               |                    |                                   | prefix for metadata fields                                          |
| timestamp_format              | iso\|epochmillis   | iso                               | event timestamp format                                              |
| event_name_separator          |                    | /                                 | event name separator                                                |
|                               |                    |                                   |                                                                     |
| index_base_pattern            | regexp             |                                   | base index pattern to generate aggregated index metrics             |
| index_base_replacement        | regexp replacement | \1                                | base index pattern replacement to generate aggregated index metrics |
|                               |                    |                                   |                                                                     |
| aggregated_index_metrics_only | bool               | false                             | for index matrics, only generate aggregated metrics                 |

#### cluster health options

Events from **[/_cluster/health?level=indices](https://www.elastic.co/guide/en/elasticsearch/reference/current/cluster-health.html)**.

| setting              | type             | default | description                                    |
|----------------------|------------------|---------|------------------------------------------------|
| cluster_health       | true\|false      | true    | enable cluster health events collect           |
| cluster_health_level | cluster\|indices | cluster | details level of the health information        |
| cluster_health_local | true\|false      | false   | retrieves information from the local node only |

#### cluster stats options

Events from **/_cluster/stats**.

| setting                        | type        | default | description                                |
|--------------------------------|-------------|---------|--------------------------------------------|
| cluster_stats                  | true\|false | false   | enable cluster stats events collect        |

#### nodes stats options

Events from **/_nodes/stats**.

| setting             | type                                                                 | default | description                       |
|---------------------|----------------------------------------------------------------------|---------|-----------------------------------|
| nodes_stats         | true\|false                                                          | true    | enable node stats events collect  |
| nodes_stats_level   | node\|indices                                                        | node    | details level for the nodes stats |
| nodes_stats_metrics | indices, os, process, jvm, thread_pool, fs, transport, http, breaker | []      |                                   |

#### indices stats options

Events from **/_all/_stats**.

| setting                         | type                     | default  | description                         |
|---------------------------------|--------------------------|----------|-------------------------------------|
| indices_stats                   | true\|false              | true     | enable indices stats events collect |
| indices_stats_level             | cluster\|indices\|shards | indices  | indices_stats details level         |
| indices                         |                          | ["_all"] | indices to collect stats on         |

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
