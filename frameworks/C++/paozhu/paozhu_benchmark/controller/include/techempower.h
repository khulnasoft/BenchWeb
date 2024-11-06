
#pragma once
#include <chrono>
#include <thread>
#include "httppeer.h"

namespace http
{

            
	std::string khulnasoftplaintext(std::shared_ptr<httppeer> peer);
	std::string khulnasoftjson(std::shared_ptr<httppeer> peer);
	std::string khulnasoftdb(std::shared_ptr<httppeer> peer);
	std::string khulnasoftqueries(std::shared_ptr<httppeer> peer);
	std::string khulnasoftfortunes(std::shared_ptr<httppeer> peer);
	std::string khulnasoftupdates(std::shared_ptr<httppeer> peer);
	std::string khulnasoftcached_queries(std::shared_ptr<httppeer> peer);
	std::string khulnasoftcached_db(std::shared_ptr<httppeer> peer);
}
