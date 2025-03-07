mkdir /tmp/profile-data

rm -rf $IROOT/ffead-cpp-6.0-sql

if [ "$1" = "batch-old" ]
then
	apt remove -yqq libpq-dev
	apt autoremove -yqq
	rm -f /usr/local/lib/libpq.*
	rm -f /usr/include/postgres_ext.h /usr/include/pg_config_ext.h /usr/include/libpq-fe.h
	rm -f /usr/lib/x86_64-linux-gnu/libpq.*
	cd /tmp
	#wget -q https://github.com/an-tao/postgres/archive/batch_mode_ubuntu.tar.gz
	#tar -xzf batch_mode_ubuntu.tar.gz
	#cd postgres-batch_mode_ubuntu
	#./configure --prefix=/usr CFLAGS='-O2 -pipe -march=native'
	#make && make install
	wget -nv https://github.com/postgres/postgres/archive/b787d4ce6d910080065025bcd5f968544997271f.zip
	unzip -q b787d4ce6d910080065025bcd5f968544997271f.zip
	cd postgres-b787d4ce6d910080065025bcd5f968544997271f
	wget -nv https://www.postgresql.org/message-id/attachment/115223/v22-0001-libpq-batch.patch
	git apply ./v22-0001-libpq-batch.patch
	./configure --prefix=/usr CFLAGS='-O3 -march=native -flto'
	cd src/interfaces/libpq
	make all install -j4
	cp ../../../src/include/postgres_ext.h ../../../src/include/pg_config_ext.h libpq-fe.h /usr/include
fi

if [ "$1" = "batch" ]
then
	apt remove -yqq libpq-dev
	apt autoremove -yqq
	rm -f /usr/local/lib/libpq.*
	rm -f /usr/include/postgres_ext.h /usr/include/pg_config_ext.h /usr/include/libpq-fe.h
	rm -f /usr/lib/x86_64-linux-gnu/libpq.*
	PG_CMT=514b4c11d24701d2cc90ad75ed787bf1380af673
	wget -nv https://github.com/postgres/postgres/archive/$PG_CMT.zip
	unzip -q $PG_CMT.zip
	cd postgres-$PG_CMT
	./configure --prefix=/usr CFLAGS='-O3 -march=native -flto'
	cd src/interfaces/libpq
	make all install -j4
	cp ../../../src/include/postgres_ext.h ../../../src/include/pg_config_ext.h /usr/include
fi

if [ "$2" = "clang" ]
then
	apt update -yqq && apt install -yqq clang
fi

cd $IROOT/ffead-cpp-src/
rm -rf $IROOT/ffead-cpp-sql-raw
rm -rf CMakeCache.txt CMakeFiles
rm -rf web/t1 web/t2

sed -i 's|add_subdirectory(${PROJECT_SOURCE_DIR}/web/t1)||g' CMakeLists.txt
sed -i 's|add_subdirectory(${PROJECT_SOURCE_DIR}/web/t2)||g' CMakeLists.txt
sed -i 's|install(FILES ${PROJECT_BINARY_DIR}/web/t1/libt1${LIB_EXT} DESTINATION ${PROJECT_NAME}-bin/lib)||g' CMakeLists.txt
sed -i 's|install(FILES ${PROJECT_BINARY_DIR}/web/t2/libt2${LIB_EXT} DESTINATION ${PROJECT_NAME}-bin/lib)||g' CMakeLists.txt

if [ "$3" = "async" ]
then
	sed -i 's|add_subdirectory(${PROJECT_SOURCE_DIR}/web/t3)||g' CMakeLists.txt
	sed -i 's|install(FILES ${PROJECT_BINARY_DIR}/web/t3/libt3${LIB_EXT} DESTINATION ${PROJECT_NAME}-bin/lib)||g' CMakeLists.txt
	sed -i 's|bw-database|localhost|g' $IROOT/ffead-cpp-src/web/t4/config/sdorm.xml
	sed -i 's|bw-database|localhost|g' $IROOT/ffead-cpp-src/web/t5/config/sdorm.xml
	rm -rf web/t3
	if [ "$4" = "pool" ]
	then
		sed -i 's|"TeBkUmLpqAsyncRouter"|"TeBkUmLpqAsyncRouterPooled"|g' $IROOT/ffead-cpp-src/web/t4/config/application.xml
		sed -i 's|TeBkUmLpqAsyncRouter|TeBkUmLpqAsyncRouterPooled|g' $IROOT/ffead-cpp-src/web/t4/config/cachememory.xml
		sed -i 's|"TeBkUmLpqQwAsyncRouter"|"TeBkUmLpqQwAsyncRouterPooled"|g' $IROOT/ffead-cpp-src/web/t5/config/application.xml
	fi
else
	sed -i 's|add_subdirectory(${PROJECT_SOURCE_DIR}/web/t4)||g' CMakeLists.txt
	sed -i 's|install(FILES ${PROJECT_BINARY_DIR}/web/t4/libt4${LIB_EXT} DESTINATION ${PROJECT_NAME}-bin/lib)||g' CMakeLists.txt
	sed -i 's|add_subdirectory(${PROJECT_SOURCE_DIR}/web/t5)||g' CMakeLists.txt
	sed -i 's|install(FILES ${PROJECT_BINARY_DIR}/web/t5/libt5${LIB_EXT} DESTINATION ${PROJECT_NAME}-bin/lib)||g' CMakeLists.txt
	sed -i 's|bw-database|localhost|g' $IROOT/ffead-cpp-src/web/t3/config/sdorm.xml
	rm -rf web/t4 web/t5
fi