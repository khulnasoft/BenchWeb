#pragma once

#include <string>

namespace userver_khulnasoft::bare {

struct SimpleResponse final {
  std::string body;
  std::string content_type;
};

}  // namespace userver_khulnasoft::bare
