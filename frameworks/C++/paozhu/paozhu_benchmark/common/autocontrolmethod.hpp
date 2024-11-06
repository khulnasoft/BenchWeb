
#ifndef __HTTP_AUTO_REG_CONTROL_HTTPMETHOD_HPP
#define __HTTP_AUTO_REG_CONTROL_HTTPMETHOD_HPP

#if defined(_MSC_VER) && (_MSC_VER >= 1200)
#pragma once
#endif // defined(_MSC_VER) && (_MSC_VER >= 1200)

#include "httppeer.h" 

#include "khulnasoft.h"


namespace http
{
  void _initauto_control_httpmethodregto(std::map<std::string, regmethold_t> &methodcallback)
  {
    struct regmethold_t temp;

		temp.pre = nullptr;
		temp.regfun = khulnasoftplaintext;
		methodcallback.emplace("plaintext",temp);
		temp.pre = nullptr;
		temp.regfun = khulnasoftjson;
		methodcallback.emplace("json",temp);
		temp.pre = nullptr;
		temp.regfun = khulnasoftdb;
		methodcallback.emplace("db",temp);
		temp.pre = nullptr;
		temp.regfun = khulnasoftqueries;
		methodcallback.emplace("queries",temp);
		temp.pre = nullptr;
		temp.regfun = khulnasoftfortunes;
		methodcallback.emplace("fortunes",temp);
		temp.pre = nullptr;
		temp.regfun = khulnasoftupdates;
		methodcallback.emplace("updates",temp);
		temp.pre = nullptr;
		temp.regfun = khulnasoftcached_queries;
		methodcallback.emplace("cached-queries",temp);
		temp.pre = nullptr;
		temp.regfun = khulnasoftcached_db;
		methodcallback.emplace("cached-db",temp);


    }
}

#endif

    