//
//  IPV6ViewController.m
//  BasicProject
//
//  Created by Li_JinLin on 17/3/10.
//  Copyright © 2017年 www.dahuatech.com. All rights reserved.
//

#import "IPV6ViewController.h"
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <err.h>

@interface IPV6ViewController ()

@end

@implementation IPV6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    strIp = [NSString stringWithFormat:@"%s",getIPV6([strIp UTF8String])] ;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define CopyString(temp) (temp != NULL)? strdup(temp):NULL

const char* getIPV6(const char * mHost) {
    if(mHost == NULL)
        return NULL;
    struct addrinfo* res0;
    struct addrinfo hints;
    struct addrinfo* res;
    
    memset(&hints, 0, sizeof(hints));
    
    hints.ai_flags = AI_DEFAULT;
    hints.ai_family = PF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    
    int n;
    if((n = getaddrinfo(mHost, "http", &hints, &res0)) != 0)
    {
        printf("getaddrinfo failed %d", n);
        return NULL;
    }
    
    struct sockaddr_in6* addr6;
    struct sockaddr_in * addr;
    const char* pszTemp;
    
    for(res = res0; res; res = res->ai_next)
    {
        char buf[32];
        if(res->ai_family == AF_INET6)
        {
            addr6 = (struct sockaddr_in6*)res->ai_addr;
            pszTemp = inet_ntop(AF_INET6, &addr6->sin6_addr, buf, sizeof(buf));
        }
        else
        {
            addr = (struct sockaddr_in*)res->ai_addr;
            pszTemp = inet_ntop(AF_INET, &addr->sin_addr, buf, sizeof(buf));
        }
        
        break;
    }
    
    freeaddrinfo(res0);
    char pszRet[256] = {0};
    if (strchr(pszTemp, ':') != NULL)
    {
        strcpy(pszRet, "[");
        strcat(pszRet, pszTemp);
        strcat(pszRet, "]");
    }
    else
    {
        strcpy(pszRet, pszTemp);
    }
    return CopyString(pszRet);
}


@end
