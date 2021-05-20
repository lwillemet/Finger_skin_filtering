# Finger_skin_filtering
2D model showing of how the stress are filtered deep in the skin tissue.

The skin can be modeled as a viscoelastic semi-infinite half plane (Wang et al. 2007). In this context, the spatiotemporal stimulation at the surface is spatially filtered  by continuum mechanics, which diffuses stresses σ(x,t) deeper in the soft tissues, where the mechanoreceptors are located. These stresses change consequently the local strains, following a linear first-order viscoelastic relaxation, resulting in a temporal filtering of the original stimulation.

To compute the strain to which the mechanoreceptors are sensitive to (Sripati 2006), the model first calculates the stress using Boussinesq and Cerruti equation (Johnson 1987). This model considers the skin as a semi-infinite homogeneous elastic medium on which a localized normal pressure p(x,t) is applied.
The equation leads to the shear and orthogonal normal stresses as a function of their position x and depth z as follows:

![Eq_stress](https://user-images.githubusercontent.com/58175648/118943402-df04f400-b953-11eb-8b31-02dc746936e9.PNG)

These equations blur of the pressure profile on the surface and diffuse the stresses on a larger area. The high spatial frequency content of the stimulation are attenuated (Wang et al. 2008). The pressure applied on the skin surface is plotted in Figure 1. The stress profile deep in the skin tissue are shown in Figure 2.

The stresses induce a deformation of the body which follows the viscoelastic Hooke's law. The compressive and shear strains ε can be expressed, in the Laplace domain, as a function of the local stresses:

![Eq_strain](https://user-images.githubusercontent.com/58175648/118943420-e3c9a800-b953-11eb-8299-6f228dbbbecd.PNG)

where L is the Laplace transform, ν is the Poisson's coefficient and E* = E + s η is the complex Young modulus of the skin layers, with E = 1.1 MPa the elastic modulus and η is the viscosity of the skin and s the Laplace operator. 
Time variation of the strain is computed numerically using a 4th-order Runge-Kutta solver. The viscoelastic behavior leads to a low-pass filtering of the surface pressure with a cut-off frequency set to E/η = 100 Hz. 


**References:**
Johnson, K. L., & Johnson, K. L. (1987). Contact mechanics. Cambridge university press.
Sripati, A. P., Bensmaia, S. J., & Johnson, K. O. (2006). A continuum mechanical model of mechanoreceptive afferent responses to indented spatial patterns. Journal of neurophysiology, 95(6), 3852-3864.
Wang, Q., & Hayward, V. (2007). In vivo biomechanics of the fingerpad skin under local tangential traction. Journal of biomechanics, 40(4), 851-860.
Wang, Q., & Hayward, V. (2008). Tactile synthesis and perceptual inverse problems seen from the viewpoint of contact mechanics. ACM Transactions on Applied Perception (TAP), 5(2), 1-19.
