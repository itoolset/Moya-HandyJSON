# Response+HandyJSON

## Compatible with Moya 9.0.0+

## Usage

```Swift
MoyaProvider<YourTarget>().rx.request(YourAPI)
    .asObservable()
    .mapObject(YourModel)
```
