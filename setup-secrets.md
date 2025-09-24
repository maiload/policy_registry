# GitHub Secrets 설정 가이드

## 필수 GitHub Secrets 설정

GitHub 저장소에서 다음 Secrets를 설정해야 합니다.

### 1. GitHub 저장소 Settings 접속
```
https://github.com/maiload/policy_registry/settings/secrets/actions
```

### 2. 필요한 Secrets 추가

다음 Secrets를 "New repository secret"으로 추가:

#### NCR_REGISTRY
- **설명**: NHN Cloud Registry 주소
- **예시**: `example.kr.ncr.nhncloudservice.com`
- **획득 방법**: NHN Cloud Console → Container → NHN Container Registry → Registry 정보

#### NCR_ACCESS_KEY
- **설명**: NHN Cloud 사용자 Access Key
- **예시**: `XXXXXXXXXXXXXXXX`
- **획득 방법**:
  1. NHN Cloud Console 로그인
  2. 우측 상단 계정 → API 보안 설정
  3. User Access Key ID 복사

#### NCR_SECRET_KEY
- **설명**: NHN Cloud 사용자 Secret Key
- **예시**: `YYYYYYYYYYYYYYYY`
- **획득 방법**:
  1. NHN Cloud Console 로그인
  2. 우측 상단 계정 → API 보안 설정
  3. Secret Access Key 확인 (최초 생성시에만 확인 가능)

## 설정 예시

```yaml
# GitHub Secrets에 설정할 값들
NCR_REGISTRY: opa.kr.ncr.nhncloudservice.com
NCR_ACCESS_KEY: ABC123DEF456GHI789
NCR_SECRET_KEY: 123abc456def789ghi
```

## 로컬 테스트

GitHub Actions 실행 전 로컬에서 테스트:

```bash
# Policy CLI 설치 (Mac)
brew tap opcr-io/tap
brew install opcr-io/tap/policy

# 또는 직접 다운로드 (Linux/Mac)
curl -L https://github.com/opcr-io/policy/releases/latest/download/policy_$(uname)_$(uname -m).tar.gz -o policy.tar.gz
tar -xzf policy.tar.gz
sudo mv policy /usr/local/bin/

# NCR 로그인 테스트
policy login -s <NCR_REGISTRY> -u <ACCESS_KEY> -p <SECRET_KEY>

# 정책 빌드 테스트
policy build ./policies -t <NCR_REGISTRY>/policy_registry:v1

# 정책 푸시 테스트
policy push <NCR_REGISTRY>/policy_registry:v1
```

## 트러블슈팅

### 인증 실패
- Access Key/Secret Key 올바른지 확인
- NHN Cloud Console에서 API 보안 설정 활성화 확인

### Registry 접근 실패
- Registry URL이 올바른지 확인
- 네트워크/방화벽 설정 확인

