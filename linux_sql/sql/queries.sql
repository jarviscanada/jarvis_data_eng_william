--Group hosts by hardware info
SELECT info.cpu_number, id, info.total_mem
FROM host_info AS info
ORDER BY info.cpu_number, info.total_mem desc;


--Average memory usage.
SELECT host_id, hostname,
Date_trunc('hour', use.timestamp)+ interval '5 minute'*round(date_part('minute', use.timestamp)/5.0) AS time,
(AVG(info.total_mem - use.memory_free * 1024) / info.total_mem *100)::INT AS avg_used_mem_percentage
FROM host_usage use, host_info info
WHERE use.host_id= info.id
GROUP BY
use.host_id, info.hostname, info.total_mem, time
ORDER BY use.host_id;