


```bash
ns-process-data images --data 20260610-chien --output-dir 20260610-chien-train

# http://localhost:7007/
ns-train splatfacto --data 20260610-chien-train


ns-train splatfacto-big \
  --data 20260610-chien-train \
  nerfstudio-data \
  --downscale-factor 1
```


https://docs.nerf.studio/nerfology/methods/splat.html#exporting-splats

