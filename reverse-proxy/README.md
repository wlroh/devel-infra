# 로컬 개발 환경 구성을 위한 용도


## How to use

```
# 도커 이미지 빌드하기 위해 해당 디렉토리 이동
cd ./image

# 도커 이미지 빌드
docker build -t local-reverse-proxy .

# 리버스 프록시 실행
cd ..
docker compose up -d

# 리버스 프록시 로그 확인
docker logs -f reverse-proxy
```

## 추가

- Mac의 경우 network-mode를 host로 설정해도 리눅스, 윈도우와 다르게 접근이 안되어 bridge 모드를 사용 후 `host.docker.internal`를 이용해 로컬에 접근하다록 변경.