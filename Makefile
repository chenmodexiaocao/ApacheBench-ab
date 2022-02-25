all: libapr ab apr-skeleton

libapr:
	make -C ./apr/ all
	
apr-skeleton.o: apr-skeleton.c
	gcc -c apr-skeleton.c -I./apr/aprutil-build/include/apr-1/ -I./apr/apr-build/include/apr-1/ -D_REENTRANT -D_GNU_SOURCE  -g

apr-skeleton: apr-skeleton.o
	gcc apr-skeleton.o -o apr-skeleton -L./apr/apr-build/lib/ -L/usr/lib64/ -static -lapr-1 -Wl,-Bdynamic -lpthread -lc 


ab.o: ab.c
	gcc -c ab.c -I./apr/aprutil-build/include/apr-1/ -I./apr/apr-build/include/apr-1/ -D_REENTRANT -D_GNU_SOURCE -D_LARGEFILE64_SOURCE -g -I/usr/local/oppo_quic/openssl/include/

ab: ab.o
	gcc ab.o -L./apr/apr-build/lib/ -L./apr/aprutil-build/lib/ -L/usr/lib64 -Wl,-rpath=./apr/apr-build/lib/ -Wl,-rpath=./apr/aprutil-build/lib  -lapr-1 -laprutil-1 -lm -lc -lpthread -Wl,-rpath=/usr/local/oppo_quic/openssl/lib/   -L/usr/local/oppo_quic/openssl/lib/ -L/lib64/ -l:libssl.so.1.1 -l:libcrypto.so.1.1 -l:ld-linux-x86-64.so.2 -o ab


clean:
	make -C ./apr/ clean
	rm ab apr-skeleton *.o
