# serverless-codepipeline

codebuild上で

```
"NODE_ENV=production components-v1"
```

を実行することにより、slsデプロイをcodepipelineにのせている

### 削除するとき

```
"NODE_ENV=production components-v1 && NODE_ENV=production components-v1 remove"
```
としなければならない。
（一度`components-v1`でデプロイを行ってから`components-v1 remove`で削除する）
