# PolygonMoblieDApp
Poygon上で動作するDApp用のリポジトリです。

## 注意事項！！
 このリポジトリ内で使用している秘密鍵は開発用です！！  
 絶対に本番では使用しないでください。

### デプロイした結果例
 ```cmd
  Starting migrations...
======================
> Network name:    'development'
> Network id:      5777
> Block gas limit: 6721975 (0x6691b7)


1_todo_contract_migration.js
============================

   Deploying 'TodoContract'
   ------------------------
   > transaction hash:    0x762786e30fe834c15c8713335f10789cca002bd1a30d192ae60f7ad90a48c494
   > Blocks: 0            Seconds: 0
   > contract address:    0xB925314e7D3CD05110cEE94F9E8B8fC2E970F757
   > block number:        1
   > block timestamp:     1654927952
   > account:             0x1C0528E014E0f9858Fd9DC883f02d8c2d38de5Ca
   > balance:             99.98533284
   > gas used:            733358 (0xb30ae)
   > gas price:           20 gwei
   > value sent:          0 ETH
   > total cost:          0.01466716 ETH

   > Saving artifacts
   -------------------------------------
   > Total cost:          0.01466716 ETH


Summary
=======
> Total deployments:   1
> Final cost:          0.01466716 ETH
 ```

 以下は、Mubaiネットワークへデプロイした時の記録
 ```cmd
 Compiling your contracts...
===========================
> Everything is up to date, there is nothing to compile.



Starting migrations...
======================
> Network name:    'munbai'
> Network id:      80001
> Block gas limit: 20000000 (0x1312d00)


1_todo_contract_migration.js
============================

   Deploying 'TodoContract'
   ------------------------
   > transaction hash:    0x03844cf607d358eb70c7a7be00d472cb12fce05bb52da92c271b7cda0f013750
   > Blocks: 0            Seconds: 4
   > contract address:    0x7B31aa8Df58697f1F8723372Fe1C1D1ba1050A6A
   > block number:        26696899
   > block timestamp:     1654933956
   > account:             0x51908F598A5e0d8F1A3bAbFa6DF76F9704daD072
   > balance:             2.811972050906778352
   > gas used:            734758 (0xb3626)
   > gas price:           2.500000011 gwei
   > value sent:          0 ETH
   > total cost:          0.001836895008082338 ETH

   Pausing for 2 confirmations...
   ------------------------------
   > confirmation number: 1 (block: 26696900)
   > confirmation number: 2 (block: 26696901)
   > Saving artifacts
   -------------------------------------
   > Total cost:     0.001836895008082338 ETH


Summary
=======
> Total deployments:   1
> Final cost:          0.001836895008082338 ETH
 ```

### フロント側アプリ起動方法
 `cd client`  
 `flutter run`