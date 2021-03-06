% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/occDetFunc.r
\name{occDetFunc}
\alias{occDetFunc}
\title{Occupancy detection Function}
\usage{
occDetFunc(taxa_name, occDetdata, spp_vis, n_iterations = 5000, nyr = 3,
  burnin = 1500, thinning = 3, n_chains = 3, write_results = TRUE,
  output_dir = getwd(), model.file = occDetBUGScode, seed = NULL)
}
\arguments{
\item{taxa_name}{A character giving the name of the species to be modelled.}

\item{occDetdata}{The 2nd element of the object returned by formatOccData.}

\item{spp_vis}{The 1st element of the object returned by formatOccData.}

\item{n_iterations}{numeric, An MCMC parameter - The number of interations}

\item{nyr}{numeric, the minimum number of years on which a site must have records for it
to be included in the models}

\item{burnin}{numeric, An MCMC parameter - The length of the burn in}

\item{thinning}{numeric, An MCMC parameter - The thinning factor}

\item{n_chains}{numeric, an MCMC parameter - The number of chains to be run}

\item{write_results}{logical, should results be saved to \code{output_dir}. This is
recommended since these models can take a long time to run. If \code{TRUE} (default)
the results from each species will be saved as an .rdata file once the species
has run. This prevents loss of data should anything go wrong.}

\item{output_dir}{character, the output directory were the output for each taxa will be saved
as .rdata files. This will defualt to the working directory}

\item{model.file}{optionally a user defined BUGS model coded as a function (see \code{?jags},
including the example there, for how this is done)}

\item{seed}{numeric, uses \code{set.seed} to set the randon number seed. Setting
this number ensures repeatabl analyses}
}
\value{
A list of filepaths, one for each species run, giving the location of the
        output saved as a .rdata file, containing an object called 'out'
}
\description{
Run occupancy detection models using the output from \code{formatOccData}
}
\details{
This function requires both the R package R2jags and the program JAGS.
These are not installed by default when sparta is loaded and so should be
installed by the user. More details can be found in teh vignette.
}
\examples{
\dontrun{

# Create data
n <- 15000 #size of dataset
nyr <- 20 # number of years in data
nSamples <- 100 # set number of dates
nSites <- 50 # set number of sites

# Create somes dates
first <- as.Date(strptime("2010/01/01", "\%Y/\%m/\%d")) 
last <- as.Date(strptime(paste(2010+(nyr-1),"/12/31", sep=''), "\%Y/\%m/\%d")) 
dt <- last-first 
rDates <- first + (runif(nSamples)*dt)

# taxa are set as random letters
taxa <- sample(letters, size = n, TRUE)

# three sites are visited randomly
site <- sample(paste('A', 1:nSites, sep=''), size = n, TRUE)

# the date of visit is selected at random from those created earlier
time_period <- sample(rDates, size = n, TRUE)

# Format the data
visitData <- formatOccData(taxa = taxa, site = site, time_period = time_period)

# run the model with these data for one species (very small number of iterations)
results <- occDetFunc(taxa_name = taxa[1],
                      n_iterations = 50,
                      burnin = 15, 
                      occDetdata = visitData$occDetdata,
                      spp_vis = visitData$spp_vis,
                      write_results = FALSE)
}
}
\references{
Isaac, N.J.B., van Strien, A.J., August, T.A., de Zeeuw, M.P. and Roy, D.B. (2014).
            Statistics for citizen science: extracting signals of change from noisy ecological data.
            Methods in Ecology and Evolution, 5 (10), 1052-1060.
}
\keyword{bayesian,}
\keyword{distribution,}
\keyword{modeling}
\keyword{occupancy,}
\keyword{species,}
\keyword{trends,}

