# Preview

Le preview est un ensemble de `scripts PowerShell` qui permettent de
tester rapidement une fonctionalité en test pas encore supporté par les équipes.

| Nom du script                           | Utilisation                                                                               |
| --------------------------------------- | ----------------------------------------------------------------------------------------- |
| `script_USER_OIDC_DeviceFlow.ps1`                  | Demonstration du OIDC device flow                                              |


Les données et identifiants sont issues de la [Sandbox / bac à sable](https://gitlab-repo-gpf.apps.eul.sncf.fr/dosn/iam/3625/documentationFederation/-/wikis/OIDC/index#sand-box)
et ne sont tronquées et anonymisées.

## Installation

Télécharger les scripts via `web` ou via `git`

```bash
git clone https://gitlab-repo-gpf.apps.eul.sncf.fr/dosn/iam/3625/documentationFederation.git
```

## Utilisation simple

Les scripts sont fonctionnels directement. Pour voir le fonctionnement, lancer les:

```powershell
PS C:\Users\PDSN02871\Downloads> .\script_M2M_sandbox.ps1
Access token endpoint :


scope         : openid
expires_in    : 35999
token_type    : Bearer
refresh_token : 892ab641-7f9e-4d05-91eb-990d5d11c4f2
id_token      : eyAidHlwIjogIkpXVCIsICJhbGciOiAiUlMyNTYiLCAia2lkIjogIkdZRVFOb2U3YlFPemRhZWFmcDhBaFgzZDBJQT0iIH0.eyAidG9rZW5OYW1lIjogImlkX3Rva2VuIiwgImF6cCI6ICJTYW5kQm94T3BlbmFtX00yTSIsICJzdWIiOiAiRmVkZXJhdGlvbklkZW50aXRlX1NhbmRCb3giLCAiYXRfaGFzaCI6ICJKZ3dtUWVjNDIwQW1tUFRQZGZOc0pnIiwgImlzcyI6ICJodHRwczovL2lkcC1kZXYuc25jZi5mcjo0NDMvb3BlbmFtL29hdXRoMi9NMk0iLCAib3JnLmZvcmdlcm9jay5vcGVuaWRjb25uZWN0Lm9wcyI6ICIzYTMwNzRjYS0yNzZiLTQyMGEtOGE4OC1lY2FjMjg5MzdhMjYiLCAiaWF0IjogMTYxNTIyNzQ0MywgImF1dGhfdGltZSI6IDE2MTUyMjc0NDMsICJleHAiOiAxNjE1MjYzNDQzLCAidG9rZW5UeXBlIjogIkpXVFRva2VuIiwgImF1ZGl0VHJhY2tpbmdJZCI6ICIxOWRmYThiOC1mNDlhLTQ5MTctYmFiMC1jMDU4ZTRjZGIxNTAtNzgwOTQ3IiwgInJlYWxtIjogIi9NMk0iLCAiYXVkIjogIlNhbmRCb3hPcGVuYW1fTTJNIiB9.gtDKon87_CsU-MlLwVCW7Jmtthg5hfXyRbp0qe0ZyeCPjEtjF5ucrrgdS-siTsQ-Q_8VB39jBrv6JitDPwsMFVq_TTZburu6-MiFB4ezPi-V9NyH4TgQQ8WXBxc26K0IjXszcQuHw6WfiqGEiFp-o-ZZEVw2vChA_jTBbUaEDVH__7uVw1bcXjyj4dLTquv1SmPfY6vRHk-B-_6YCHCiVcF6HR0Umw1nAP7CNffFSQXiuLWpNKzoeaS4Mvx2gxqRUKz4S81xP_Qe6MJMG-V_2sfP_di61hkDpMDzcAJ8RNzOVmKEMXW5C3uXKQ-9_29dQE5C6aO77JWWam5ocYAz9g
access_token  : bb64c5d3-636e-4e33-972b-019b757b7dae

User Info endpoint :
sub        : FederationIdentite_SandBox
updated_at : 1614756987
id_token   : eyAidHlwIjogIkpXVCIsICJhbGciOiAiUlMyNTYiLCAia2lkIjogIkdZRVFOb2U3YlFPemRhZWFmcDhBaFgzZDBJQT0iIH0.eyAiYXV0aF90aW1lIjogMTYxNTIyNzQ0NCwgInRva2VuTmFtZSI6ICJpZF90b2tlbiIsICJleHAiOiAxNjE1MjYzNDQ0LCAic3ViIjogIkZlZGVyYXRpb25JZGVudGl0ZV9TYW5kQm94IiwgImF6cCI6ICJTYW5kQm94T3BlbmFtX00yTSIsICJ0b2tlblR5cGUiOiAiSldUVG9rZW4iLCAiaXNzIjogImh0dHBzOi8vaWRwLWRldi5zbmNmLmZyOjQ0My9vcGVuYW0vb2F1dGgyL00yTSIsICJhdWQiOiAiU2FuZEJveE9wZW5hbV9NMk0iLCAiaWF0IjogMTYxNTIyNzQ0NCB9.A3ttKr4g2o2RCdkD8c2vomNJd4LSh_YKjDQusdhy1siLpxFkb263SSqr99n4yLPDUSpHhYYliG0jwjtFkiEpCTHZKJZlonj6WqFeT3WVN6GcoBa5SLPgCB199dI9AN_V0j2XX8ToDSlSrY0DT-qankm5tFwtyxrftZPgYUhZqVre2v9gj9yE0-bkKOeUaHpyakRvSfKCJzPy84tWZQxTqI8fUmmGNNQmTegPwY5LEpr9yynTkGrikVAkx4f_b-jYKQ7vTD-0FwV21HBvqvMfb3PS5Bt9Kfpu6DYGKFq58wsmmDMUILO_PWWBYOS3HkplTiIH9XierVwUQ3hwp1cs0w

PS C:\Users\PDSN02871\Downloads>
```

## Utilisation avancée

Pour vérifier les différents identifiants reçus lors de la souscription au SAA
sont corrects, vous pouvez utiliser le.s script.s avec **vos identifiants**:

1. Mettre vos identifiants OIDC fournis par la FID (comme `monAppli_M2M`)

    ```powershell
    #Saisir le clientID/Secret, qui seront codés en Base64
    $ClientIDS="monAppli_M2M:123456789"
    ```

2. Mettre vos comptes de services RID fournis par le SAA (comme `monAppli_Account`)

    ```powershell
    #Login mot de passe du compte de service RID
    $username = 'FederationIdentite_Account'
    $password = 'ABCDEFGHI'
    ```
