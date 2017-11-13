# Copyright 2017 Rafal Zajac <rzajac@gmail.com>.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.


# The example doesn't use cmake find_package() function because we want
# local libraries not the ones installed in $ESPROOT.

find_package(esp_sdo REQUIRED)

add_executable(cmd_example
    main.c
    wifi.c
    include/wifi.h
    ${ESP_USER_CONFIG})

target_include_directories(cmd_example PUBLIC
    ${esp_sdo_INCLUDE_DIRS}
    ${ESP_USER_CONFIG_DIR})

target_link_libraries(cmd_example
    ${esp_sdo_LIBRARIES}
    esp_cmd)

esp_gen_exec_targets(cmd_example)
