--Group hosts by hardware info
SELECT cpu_number, id, total_mem
FROM host_info, total_mem DESC;
