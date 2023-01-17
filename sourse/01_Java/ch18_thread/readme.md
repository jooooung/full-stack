# Thread
# 프로세스와 쓰레드
- 실행가능한 보조기억장치(HDD, SSD)에 있는 파일 : 프로그램
- 프로그램이 메모리에 상주한다 : 프로세스
- 하나의 CPU가 동시에 여서 프로그램을 동시에 실행 : 멀티 프로세스
- 멀티 프로세스는 동시에 실행되는 게 아닌 CPU에서 각 프로세스들의 실행을 잘게 나누어서 실행하는 것이다
---
- 쓰레드 : 하나의 프로그램이 동시에 여러 개의 일을 수행할 수 있도록 하는 것  
즉 하나의 프로세스에서 다시 여러 가지 일을 하는 것을 뜻한다
- JAVA는 기본적으로 멀티스레드를 지원하기 위해 java.lang.Thread 클래스를 제공
---
## 멀티쓰레드
- 쓰레드는 두가지 형태로 존재
  - n개의 스레드가 객체 하나를 공유하는 방식
  - n개의 스레드가 각각 객체 n개를 사용하는 방식
- 멀티쓰레드의 장점  
1. 자원을 보다 효율적으로 사용할 수 있다.
2. 사용자에 대한 응답성이 향상된다.
3. 작업이 분리되어 코드가 간결해 진다.
- 멀티쓰레드의 단점
1. 동기화(synchronization)에 주의해야 한다.
2. 교착상태(dead-lock)가 발생하지 않도록 주의해야 한다.
3. 각 쓰레드가 효율적으로 고르게 실행될 수 있게 해야 한다(☞프로그래밍할 때 고려해야 할 사항들이 많다)
---

## 쓰레드의 생명주기 
![](https://velog.velcdn.com/images/dkswndrnjs12/post/5f838ff5-0590-44d8-8493-45344d930058/image.PNG)

# Synchronized
- 먼저 수행되는 쓰레드의 모든 작업이 끝날 때까지 다른 쓰레드는 기다리도록 하는 예약어
- 즉 하나의 자원을 여러 태스크가 사용하려 할 때, 한 시점에서 하나의 태스크만이 사용할수 있도록 하는 것
- 예를 들어 영화 예매 시 좌석을 선택 할 때 같은 좌석을 여러 사람이 동시에 예매하게 되면 안된다. 따라서 한 좌석은 한 사람만이 예매할 수 있도록 해야한다