--Group hosts by hardware info
SELECT info.cpu_number, id, info.total_mem
FROM host_info AS info
ORDER BY info.cpu_number, info.total_mem desc;
